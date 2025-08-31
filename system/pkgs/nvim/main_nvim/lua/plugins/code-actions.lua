return {
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "LspAttach",
		opts = {
			backend = "vim",
			picker = {
				"buffer",
				opts = {
					hotkeys = true,
					winborder = "rounded",
				},
			},
		},
	},
}
