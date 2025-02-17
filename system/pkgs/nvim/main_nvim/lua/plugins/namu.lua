return {
	{
		"bassamsdata/namu.nvim",
		event = "LSPAttach",
		keys = {
			{
				"<leader>ln",
				"<cmd>Namu symbols<CR>",
				desc = "Document Symbols",
				{ silent = true },
			},
		},
		opts = {
			namu_symbols = {
				enabled = true,
				options = {},
			},
			colorscheme = { enabled = false },
			ui_select = { enabled = false },
		},
	},
}
