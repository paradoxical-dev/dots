return {
	{
		"leath-dub/snipe.nvim",
		keys = {
			{
				"<leader>bs",
				function()
					require("snipe").open_buffer_menu()
				end,
				desc = "Open Snipe",
			},
		},
		opts = {
			ui = {
				max_height = 13,
				open_win_override = {
					border = "rounded",
				},
				position = "bottomright",
			},
		},
	},
}
