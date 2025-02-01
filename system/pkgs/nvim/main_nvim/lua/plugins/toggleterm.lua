return {
	{
		"akinsho/toggleterm.nvim",
		lazy = true,
		keys = {
			{
				"<leader>tf",
				"<cmd>ToggleTerm direction=float<CR>",
				desc = "Floating Terminal",
			},
			{
				"<leader>th",
				"<cmd>ToggleTerm direction=horizontal<CR>",
				desc = "Horizontal Terminal",
			},
			{
				"<leader>tv",
				"<cmd>ToggleTerm direction=vertical<CR>",
				desc = "Vertical Terminal",
			},
			{
				"<leader>tn",
				function()
					local term = require("toggleterm.terminal").Terminal
					term:new({ cmd = "node", direction = "horizontal" }):toggle()
				end,
				desc = "Node REPL",
			},
			{
				"<leader>tp",
				function()
					local term = require("toggleterm.terminal").Terminal
					term:new({ cmd = "python", direction = "horizontal" }):toggle()
				end,
				desc = "Python REPL",
			},
			{
				"<leader>tr",
				function()
					local term = require("toggleterm.terminal").Terminal
					term:new({ cmd = "nix repl", direction = "horizontal" }):toggle()
				end,
				desc = "Nix REPL",
			},
			{
				"<leader>tb",
				function()
					local term = require("toggleterm.terminal").Terminal
					term:new({ cmd = "btm", direction = "float" }):toggle()
				end,
				desc = "Bottom",
			},
		},
		version = "*",
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 6
				elseif term.direction == "vertical" then
					return math.floor(vim.o.columns * 0.3)
				end
			end,
			highlights = {
				NormalFloat = {
					link = "NormalFloat",
				},
				FloatBorder = {
					link = "FloatBorder",
				},
			},
			winbar = { enabled = false },
			float_opts = {
				border = "curved",
				width = function()
					return math.floor(vim.o.columns * 0.8)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.7)
				end,
				title_pos = "center",
			},
		},
	},
}
