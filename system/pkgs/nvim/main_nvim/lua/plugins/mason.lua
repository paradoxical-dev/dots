return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		opts = {},
	},

	-- LSP CONFIG --

	{
		"paradoxical-dev/lsp_hover",
		lazy = true,
		opts = {
			default = {
				name = "󰗊 LSP/Hover",
				border_hl = "MarkviewGradient6",
				min_width = 30,
			},
			["^lua_ls"] = {
				name = " lua_ls",
				border_hl = "MarkviewGradient6",
			},
			["^nil_ls"] = {
				name = "󱄅 nil_ls",
				border_hl = "MarkviewGradient6",
			},
			["^pyright"] = {
				name = "󰌠 pyright",
				border_hl = "MarkviewGradient6",
			},
			["^denols"] = {
				name = " denols",
				border_hl = "MarkviewGradient6",
			},
			["^clangd"] = {
				name = " clangd",
				border_hl = "MarkviewGradient6",
			},
			["^cssls"] = {
				name = " cssls",
				border_hl = "MarkviewGradient6",
			},
			["^rust_analyzer"] = {
				name = " rust_analyzer",
				border_hl = "MarkviewGradient6",
			},
			["^bashls"] = {
				name = " bashls",
				border_hl = "MarkviewGradient6",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"paradoxical-dev/lsp_hover",
		},
		opts = function(_, opts)
			opts.ensure_installed = {
				"bashls",
				"clangd",
				"cmake",
				"cssls",
				"denols",
				"dockerls",
				"html",
				"lua_ls",
				"nil_ls",
				"pyright",
				"rust_analyzer",
				"yamlls",
			}

			local on_attach = function(client, bufnr)
				-- sets keymaps for lsp actions
				local options = { buffer = bufnr, remap = false }
				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, { buffer = bufnr, remap = false, desc = "Go to Definition" })

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
					require("tiny-code-action").code_action()
				end, { buffer = bufnr, remap = false, desc = "Code Actions" })

				vim.keymap.set("n", "<leader>lR", function()
					vim.lsp.buf.rename()
				end, { buffer = bufnr, remap = false, desc = "Symbol Rename" })

				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, options)

				-- sets up diagnostics
				vim.diagnostic.config({
					virtual_text = true,
					underline = true,
					update_in_insert = false,
					severity_sort = true,
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = "",
							[vim.diagnostic.severity.WARN] = "",
							[vim.diagnostic.severity.HINT] = "󰌵",
							[vim.diagnostic.severity.INFO] = "",
						},
					},
				})

				-- sets up breadcrumbs
				require("nvim-navic").attach(client, bufnr)
			end

			local lsp_config = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			for _, server_name in pairs(opts.ensure_installed) do
				lsp_config[server_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end
			return opts
		end,
	},

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
		dependencies = {
			{ "niuiic/dap-utils.nvim", dependencies = { "niuiic/core.nvim" } },
		},
		config = function()
			require("dap").adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						os.getenv("HOME")
							.. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}
			require("dap").configurations.javascript = {
				{
					name = "Launch with NPM",
					request = "launch",
					runtimeArgs = { "run-script", "debug" },
					runtimeExecutable = "npm",
					skipFiles = { "<node_internals>/**" },
					type = "pwa-node",
					-- program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					name = "Attach to process",
					type = "pwa-node",
					request = "attach",
					port = 9229,
					restart = true,
					timeout = 10000,
					skipFiles = { "<node_internals>/**" },
				},
			}
		end,
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

				chrome = function(config)
					local chrome_debug_path = os.getenv("HOME")
						.. "/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js"

					config.adapters = {
						type = "executable",
						command = "node",
						args = { chrome_debug_path },
					}

					local chrome_path = vim.fn.trim(vim.fn.system("which google-chrome-stable"))
					if chrome_path == "" then
						vim.notify("Could not find Chrome. Set 'runtimeExecutable' manually.", vim.log.levels.ERROR)
					end

					local web_root = vim.fn.getcwd() .. "/src"

					local launch_config = {
						name = "Launch Chrome",
						type = "chrome",
						request = "launch",
						url = "http://localhost:3000",
						webRoot = web_root,
						runtimeExecutable = chrome_path,
						runtimeArgs = {
							"--remote-debugging-port=9222",
							"--no-first-run",
							"--no-default-browser-check",
							"--disable-default-apps",
							"--disable-popup-blocking",
							"--user-data-dir=/tmp/vscode-chrome-debug-profile",
						},
						sourceMaps = true,
						protocol = "inspector",
					}

					local attach_config = {
						name = "Attach to Chrome",
						type = "chrome",
						request = "attach",
						port = 9222,
						webRoot = web_root,
						sourceMaps = true,
						protocol = "inspector",
					}

					config.configurations = {
						launch_config,
						attach_config,
					}

					require("mason-nvim-dap").default_setup(config)
				end,

				-- js = function(config)
				-- 	local js_debug_path = vim.fn.stdpath("data")
				-- 		.. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
				--
				-- 	config.adapters = {
				-- 		type = "server",
				-- 		host = "localhost",
				-- 		port = "${port}",
				-- 		executable = {
				-- 			command = "node",
				-- 			args = { js_debug_path, "${port}" },
				-- 		},
				-- 	}
				--
				-- 	config.configurations = {
				-- 		{
				-- 			type = "js",
				-- 			request = "launch",
				-- 			name = "Launch NPM Script",
				-- 			program = vim.fn.getcwd() .. "/index.js",
				-- 			cwd = vim.fn.getcwd(),
				-- 			runtimeExecutable = "npm",
				-- 			runtimeArgs = { "run-script", "debug" },
				-- 			skipFiles = { "<node_internals>/**" },
				-- 			sourceMaps = true,
				-- 			protocol = "inspector",
				-- 			console = "integratedTerminal",
				-- 		},
				-- 		{
				-- 			type = "js",
				-- 			request = "attach",
				-- 			name = "Attach to Process",
				-- 			-- port = 9229,
				-- 			-- restart = true,
				-- 			-- timeout = 10000,
				-- 			processId = require("dap.utils").pick_process,
				-- 			cwd = vim.fn.getcwd(),
				-- 			skipFiles = { "<node_internals>/**" },
				-- 			sourceMaps = true,
				-- 			protocol = "inspector",
				-- 		},
				-- 	}
				--
				-- 	config.filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
				--
				-- 	require("mason-nvim-dap").default_setup(config)
				-- end,

				-- js = function(config)
				-- 	local js_debug_path = vim.fn.stdpath("data")
				-- 		.. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
				--
				-- 	config.adapters = {
				-- 		type = "server",
				-- 		host = "localhost",
				-- 		port = "${port}",
				-- 		executable = {
				-- 			command = "node",
				-- 			args = { js_debug_path, "${port}" },
				-- 		},
				-- 	}
				--
				-- 	local configurations = {
				-- 		{
				-- 			type = "pwa-node",
				-- 			request = "launch",
				-- 			name = "Launch Express App",
				-- 			program = "${workspaceFolder}/index.js",
				-- 			cwd = "${workspaceFolder}",
				-- 			runtimeExecutable = "node",
				-- 			skipFiles = { "<node_internals>/**" },
				-- 			sourceMaps = true,
				-- 			console = "integratedTerminal",
				-- 		},
				-- 		{
				-- 			type = "pwa-node",
				-- 			request = "attach",
				-- 			name = "Attach to Process",
				-- 			processId = require("dap.utils").pick_process,
				-- 			cwd = "${workspaceFolder}",
				-- 			skipFiles = { "<node_internals>/**" },
				-- 		},
				-- 	}
				--
				-- 	config.configurations = config.configurations or {}
				-- 	vim.list_extend(config.configurations, configurations)
				--
				-- 	-- config.configurations.typescript = config.configurations.javascript
				--
				-- 	require("mason-nvim-dap").default_setup(config)
				-- end,

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
