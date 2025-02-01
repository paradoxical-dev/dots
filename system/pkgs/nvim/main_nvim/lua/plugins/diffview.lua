return {
	{
		"sindrets/diffview.nvim",
		lazy = true,
		keys = {
			{
				"<leader>gD",
				function()
					vim.ui.input({ prompt = "Commit rev or path: (leave blank for current)" }, function(target)
						if not target then
							return
						end
						if target == "" then
							vim.cmd("DiffviewOpen")
						else
							vim.cmd("DiffviewOpen " .. target)
						end
					end)
				end,
				desc = "Diff View",
			},
			{
				"<leader>gF",
				function()
					vim.ui.input(
						{ prompt = "Commit rev or path: (leave blank for current branch)", completion = "file" },
						function(target)
							if not target then
								return
							end
							if target == "" then
								vim.cmd("DiffviewFileHistory")
							else
								vim.cmd("DiffviewFileHistory " .. target)
							end
						end
					)
				end,
				desc = "Diff View File Hist",
			},
		},
	},
}
