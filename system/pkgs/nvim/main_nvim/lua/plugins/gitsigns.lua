return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		keys = {
			{
				"]c",
				function()
					require("gitsigns").next_hunk()
				end,
				desc = "Next Hunk",
			},
			{
				"[c",
				function()
					require("gitsigns").prev_hunk()
				end,
				desc = "Previous Hunk",
			},
			{
				"<leader>gh",
				function()
					require("gitsigns").stage_hunk()
				end,
				desc = "Stage/Unstage Hunk",
			},
			{
				"<leader>gH",
				function()
					require("gitsigns").reset_hunk()
				end,
				desc = "Reset Hunk",
			},
			{
				"<leader>gp",
				function()
					require("gitsigns").preview_hunk()
				end,
				desc = "Preview Hunk",
			},
			{
				"<leader>gw",
				function()
					require("gitsigns").blame()
				end,
				desc = "Stage/Unstage Hunk",
			},
		},
		opts = {},
	},
}
