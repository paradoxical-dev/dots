return {
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		dependencies = {
			"folke/snacks.nvim",
		},
		keys = {
			-- {
			-- 	"<leader>of",
			-- 	mode = { "n", "v" },
			-- 	"<cmd>Yazi<cr>",
			-- 	desc = "Open Yazi In Current File",
			-- },
			-- {
			-- 	"<leader>oc",
			-- 	mode = { "n", "v" },
			-- 	"<cmd>Yazi cwd<cr>",
			-- 	desc = "Open Yazi In CWD",
			-- },
			{
				"<leader>o",
				mode = { "n", "v" },
				"<cmd>Yazi toggle<cr>",
				desc = "Yazi",
			},
		},
		opts = {},
	},
}
