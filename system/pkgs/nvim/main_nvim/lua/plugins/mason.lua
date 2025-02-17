return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		opts = {},
	},

	-- LSP CONFIG --

	{ "paradoxical-dev/lsp_hover", lazy = true },
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = function(_, opts)
			opts.ensure_installed = {
				"lua_ls",
			}

			local on_attach = function(client, bufnr)
				-- sets keymaps for lsp actions
				local options = { buffer = bufnr, remap = false }
				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, { buffer = bufnr, remap = false, desc = "Go to Definition" })
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, { buffer = bufnr, remap = false, desc = "Hover Info" })
				vim.keymap.set("n", "<leader>lf", function()
					vim.diagnostic.open_float()
				end, { buffer = bufnr, remap = false, desc = "Diagnostic Float" })
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_next()
				end, { buffer = bufnr, remap = false, desc = "Next Diagnostic" })
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_prev()
				end, { buffer = bufnr, remap = false, desc = "Previous Diagnostic" })
				vim.keymap.set("n", "<leader>lc", function()
					vim.lsp.buf.code_action()
				end, { buffer = bufnr, remap = false, desc = "Code Actions" })
				vim.keymap.set("n", "<leader>lR", function()
					vim.lsp.buf.rename()
				end, { buffer = bufnr, remap = false, desc = "Symbol Rename" })
				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, options)

				-- sets icons for diagnostics
				vim.diagnostic.config({
					virtual_text = true,
					signs = true,
					underline = true,
					update_in_insert = false,
					severity_sort = true,
				})
				local signs = {
					Error = "",
					Warn = "",
					Hint = "󰌵",
					Info = "",
				}
				for type, icon in pairs(signs) do
					local hl = "DiagnosticSign" .. type
					vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
				end

				-- sets up navic
				require("nvim-navic").attach(client, bufnr)

				-- fancy lsp hover
				require("lsp_hover").setup({
					default = {
						border_hl = "FloatBorder",
					},
					["^lua_ls"] = {
						name = " lua_ls",
						border_hl = "FloatBorder",
					},
				})
			end

			local lsp_config = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			opts.handlers = {
				-- default setup for servers
				function(server_name)
					lsp_config[server_name].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
			}
		end,
	},
	{ "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } },

	-- NULL-LS --

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		keys = {},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"stylua",
					"jq",
				},
				handlers = {},
			})
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			require("null-ls").setup({
				-- auto format on save
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			})
		end,
	},

	-- DAP --

	{
		"mfussenegger/nvim-dap",
		lazy = true,
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		opts = {},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"rcarriga/nvim-dap-ui",
		},
		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end,
				desc = "Set Breakpoint w/ Log",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Continue",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step Into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Step Over",
			},
			{
				"<leader>du",
				function()
					require("dap").step_out()
				end,
				desc = "Step Out",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "Open REPL",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run Last",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle UI",
			},
		},
		opts = {
			ensure_installed = {
				"python",
				"clang",
				"bash",
				"chrome",
				"js",
				"cppdbg",
			},
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,

				bash = function(config)
					config.adapters = {
						type = "executable",
						command = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/bash-debug-adapter",
					}
					require("mason-nvim-dap").default_setup(config)
				end,

				python = function(config)
					local path = vim.fn.system("which python")
					path = path:gsub("%s+$", "")
					config.adapters = {
						type = "executable",
						command = path,
						args = { "-m", "debugpy.adapter" },
						options = {
							source_filetype = "python",
						},
					}
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		},
	},
}
