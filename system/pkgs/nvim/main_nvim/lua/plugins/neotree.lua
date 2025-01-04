return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = true,
		keys = {
			{ "<leader>o", "<cmd>Neotree toggle<CR>", desc = "Toggle NeoTree" },
		},
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			window = {
				width = 25,
			},
		},
	},
}
