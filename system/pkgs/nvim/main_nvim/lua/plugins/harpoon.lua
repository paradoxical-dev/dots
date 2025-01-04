return {
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>ha",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Mark File",
			},
			{
				"<leader>hu",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "Toggle Menu",
			},
			{
				"<leader>hh",
				function()
					require("harpoon.ui").nav_file(1)
				end,
				desc = "Harpoon 1",
			},
			{
				"<leader>hj",
				function()
					require("harpoon.ui").nav_file(2)
				end,
				desc = "Harpoon 2",
			},
			{
				"<leader>hk",
				function()
					require("harpoon.ui").nav_file(3)
				end,
				desc = "Harpoon 3",
			},
			{
				"<leader>hl",
				function()
					require("harpoon.ui").nav_file(4)
				end,
				desc = "Harpoon 4",
			},
		},
	},
}
