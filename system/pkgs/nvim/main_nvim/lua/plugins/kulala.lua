return {
	{
		{
			"mistweaverco/kulala.nvim",
			event = { "BufReadPre" },
			ft = { "http" },
			keys = {
				{
					"<leader>rr",
					function()
						require("kulala").run()
					end,
					desc = "Run Current Request",
				},
				{
					"<leader>rR",
					function()
						require("kulala").run_all()
					end,
					desc = "Run Current Buffer",
				},
				{
					"<leader>rl",
					function()
						require("kulala").replay()
					end,
					desc = "Replay Last Request",
				},
				{
					"<leader>ri",
					function()
						require("kulala").inspect()
					end,
					desc = "Inspect Request",
				},
				{
					"<leader>rS",
					function()
						require("kulala").show_stats()
					end,
					desc = "Last Run Stats",
				},
				{
					"<leader>rs",
					function()
						require("kulala").scratchpad()
					end,
					desc = "Scratchpad",
				},
				{
					"<leader>rc",
					function()
						require("kulala").copy()
					end,
					desc = "Request To Curl",
				},
				{
					"<leader>rC",
					function()
						require("kulala").from_curl()
					end,
					desc = "Curl To Request",
				},
				{
					"<leader>rt",
					function()
						require("kulala").toggle_view()
					end,
					desc = "Toggle Res Panel",
				},
				{
					"<leader>r/",
					function()
						require("kulala").search()
					end,
					desc = "Search Requests",
				},
				{
					"<leader>r]",
					function()
						require("kulala").jump_next()
					end,
					desc = "Next Request",
				},
				{
					"<leader>r[",
					function()
						require("kulala").jump_prev()
					end,
					desc = "Previous Request",
				},
				{
					"<leader>rx",
					function()
						require("kulala").clear_cached_files()
					end,
					desc = "Clear Cache",
				},
			},
			opts = function(_, opts)
				vim.filetype.add({
					extension = {
						["http"] = "http",
					},
				})
				return {
					display_mode = "split",
					default_view = "verbose",
				}
			end,
		},
	},
}
