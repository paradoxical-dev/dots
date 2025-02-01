return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			spec = {
				-- groups --
				{ "<leader>f", group = "Find" },
				{ "<leader>g", group = "Git" },
				{ "<leader>d", group = "DAP", icon = { icon = "", color = "red" } },
				{ "<leader>t", group = "Terminal" },
				{ "<leader>l", group = "LSP", icon = { icon = "󱞁", color = "purple" } },
				{ "<leader>b", group = "Buffers" },
				{ "<leader>u", group = "UI/UX" },
				{ "<leader>h", group = "Harpoon", icon = { icon = "󱡅", color = "grey" } },
				{ "<leader>c", group = "Chat", icon = { icon = "󰭻", color = "grey" } },
				{ "<leader>x", group = "Tests", icon = { icon = "󰙨", color = "green" } },
				{ "<leader>r", group = "REST Client", icon = { icon = "", color = "blue" } },

				-- QoL / Movement --
				{
					"J",
					":m '>+1<CR>gv=gv",
					desc = "Move Selection Down",
					mode = "v",
					icon = { icon = "", color = "orange" },
				},
				{
					"K",
					":m '<-2<CR>gv=gv",
					desc = "Move Selection Up",
					mode = "v",
					icon = { icon = "", color = "orange" },
				},

				{ "J", "mzJ`z", desc = "Join Line Below" },
				{ "<C-d>", "<C-d>zz", desc = "Scroll Down" },
				{ "<C-u>", "<C-u>zz", desc = "Scroll Up" },
				{ "n", "nzzzv", desc = "Next Search" },
				{ "N", "Nzzzv", desc = "Previous Search" },

				{
					"<leader>p",
					'"_dp',
					desc = "Paste Without Yank",
					mode = "x",
					icon = { icon = "", color = "grey" },
				},
				{ "<leader>y", '"+y', desc = "Yank To System", icon = { icon = "", color = "grey" } },
				{
					"<leader>y",
					'"+y',
					desc = "Yank To System",
					mode = "v",
					icon = { icon = "", color = "grey" },
				},
				{ "<leader>Y", '"+Y', desc = "Yank To System", icon = { icon = "", color = "grey" } },
				{ "<leader>D", '"_d', desc = "Delete Without Yank", icon = { icon = "󰺝", color = "red" } },
				{
					"<leader>D",
					'"_d',
					desc = "Delete Without Yank",
					mode = "v",
					icon = { icon = "󰺝", color = "red" },
				},

				{ "<leader>]", "<cmd>cnext<CR>zz", desc = "Next Quickfix Item" },
				{
					"<leader>[",
					"<cmd>cprev<CR>zz",
					desc = "Previous Quickfix Item",
				},
				{
					"<leader>k",
					"<cmd>lnext<CR>zz",
					desc = "Next Location List Item",
					icon = { icon = "󱋿", color = "azure" },
				},
				{
					"<leader>j",
					"<cmd>lprev<CR>zz",
					desc = "Previous Location List Item",
					icon = { icon = "󱋿", color = "azure" },
				},

				{
					"<C-w>",
					"<Cmd>wincmd w<CR>",
					mode = "t",
				},

				{ "<leader>/", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gi<Left><Left><Left>", desc = "Search and Replace" },
				{ "<leader>X", "<cmd>!chmod +x %<CR>", desc = "Make Executable" },

				-- UI/UX --
				{
					"<leader>uw",
					function()
						vim.wo.wrap = not vim.wo.wrap
						Snacks.notify.info(
							"Line wrap toggled " .. (vim.wo.wrap and "on" or "off") .. " for current window",
							{ title = "UI/UX" }
						)
					end,
					desc = "Toggle Line Wrap",
					icon = { icon = "", color = "blue" },
				},
				{
					"<leader>ud",
					function()
						local bufnr = vim.api.nvim_get_current_buf()
						if vim.b.diagnostics_disabled then
							vim.diagnostic.enable(bufnr)
							vim.b.diagnostics_disabled = false
							Snacks.notify.info("Diagnostics enabled for current buffer", { title = "UI/UX" })
						else
							vim.diagnostic.disable(bufnr)
							vim.b.diagnostics_disabled = true
							Snacks.notify.info("Diagnostics disabled for current buffer", { title = "UI/UX" })
						end
					end,
					desc = "Toggle Diagnostics",
					icon = { icon = "", color = "yellow" },
				},
				-- INFO: this is only needed when using multicursor in markdown files
				{
					"<leader>ur",
					-- "<cmd>Markview toggle<CR>",
					function()
						vim.cmd("Markview toggle")
						vim.cmd("TSToggle highlight")
						if not ufo_active then
							vim.cmd("UfoDisable")
							ufo_active = true
							Snacks.notify.info("Markdown Render and UFO Toggled Off", { title = "UI/UX" })
						else
							vim.cmd("UfoEnable")
							ufo_active = false
							Snacks.notify.info("Markdown Render and UFO Toggled On", { title = "UI/UX" })
						end
					end,
					desc = "Toggle Markdown Render",
				},

				-- Buffer Nav --
				{ "[b", "<cmd>bprev<CR>", desc = "Previous Buffer" },
				{ "]b", "<cmd>bnext<CR>", desc = "Next Buffer" },
				{
					"<leader>bC",
					function()
						local current_buf = vim.api.nvim_get_current_buf()
						for _, buf in ipairs(vim.api.nvim_list_bufs()) do
							if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
								vim.api.nvim_buf_delete(buf, { force = true })
							end
						end
						Snacks.notify.info("Closed all other buffers", { title = "Buffers" })
					end,
					desc = "Close all buffers but the current",
				},
				{
					"<leader>bc",
					function()
						local current_buf = vim.api.nvim_get_current_buf()
						vim.api.nvim_buf_delete(current_buf, { force = true })
						Snacks.notify.info("Closed current buffer", { title = "Buffers" })
					end,
					desc = "Close the current buffer",
				},
				{ "<leader>bn", "<cmd>new<CR>", desc = "New Buffer" },

				-- Window Nav --
				{ "<C-h>", "<C-w>h", desc = "Window Left" },
				{ "<C-j>", "<C-w>j", desc = "Window Down" },
				{ "<C-k>", "<C-w>k", desc = "Window Up" },
				{ "<C-l>", "<C-w>l", desc = "Window Right" },

				-- Neollama / AI --
				{
					"<leader>cc",
					function()
						require("neollama").initialize()
					end,
					desc = "Open Neollama",
				},
				{
					"<leader>c",
					function()
						require("neollama").initialize()
					end,
					mode = "v",
					desc = "Open Neollama w/ Selection",
				},
			},
			preset = "helix",
			icons = {
				group = "",
				separator = "󰅂 ",
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
