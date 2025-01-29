return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = false },
			words = { enabled = false },
			scroll = { enabled = false },

			styles = {
				zen = {
					position = "float",
					backdrop = {
						blend = 99,
						bg = "#000000",
						transparent = false,
					},
				},
				scratch = {
					position = "float",
					backdrop = {
						transparent = true,
					},
					wo = {
						winhighlight = "Normal:NormalFloat",
						winbar = "",
					},
				},
			},

			indent = {
				enabled = true,
				scope = {
					enabled = false,
				},
				chunk = {
					enabled = true,
					char = {
						corner_top = "╭",
						corner_bottom = "╰",
						arrow = "→",
					},
				},
				priority = 200,
			},

			notifier = {
				enabled = true,
				height = { min = 1, max = 0.8 },
			},

			lazygit = {
				enabled = true,
				theme = {
					activeBorderColor = { fg = "Keyword", bold = true },
				},
			},

			scratch = {
				win = { style = "scratch" },
				win_by_ft = {
					javascript = {
						keys = {
							["source"] = {
								"<cr>",
								function(self)
									local name = "scratch."
										.. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
									local handle =
										io.popen("node " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(self.buf)))
									if not handle then
										Snacks.notify.error("No output or an error occured", { title = name })
										return
									end
									local out = handle:read("*a")
									handle:close()

									if out == "" then
										out = "No output or an error occured"
									end

									Snacks.notify.info(out, { title = name, ft = "javascript" })
								end,
								desc = "Source buffer",
								mode = { "n", "x" },
							},
						},
					},
					python = {
						keys = {
							["source"] = {
								"<cr>",
								function(self)
									local name = "scratch."
										.. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
									local handle =
										io.popen("python3 " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(self.buf)))
									if not handle then
										Snacks.notify.error("No output or an error occured", { title = name })
										return
									end
									local out = handle:read("*a")
									handle:close()

									if out == "" then
										out = "No output or an error occured"
									end

									Snacks.notify.info(out, { title = name, ft = "python" })
								end,
								desc = "Source buffer",
								mode = { "n", "x" },
							},
						},
					},
					nix = {
						keys = {
							["source"] = {
								"<cr>",
								function(self)
									local name = "scratch."
										.. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
									local handle = io.popen(
										"nix-instantiate --eval "
											.. vim.fn.shellescape(vim.api.nvim_buf_get_name(self.buf))
									)
									if not handle then
										Snacks.notify.error("No output or an error occured", { title = name })
										return
									end
									local out = handle:read("*a")
									handle:close()

									if out == "" then
										out = "No output or an error occured"
									end

									Snacks.notify.info(out, { title = name, ft = "nix" })
								end,
								desc = "Source buffer",
								mode = { "n", "x" },
							},
						},
					},
				},
			},

			dashboard = {
				-- enabled = false,
				-- 				preset = {
				-- 					header = [[
				--
				--
				-- ⠤⣤⣤⣤⣄⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣠⣤⠤⠤⠴⠶⠶⠶⠶
				-- ⢠⣤⣤⡄⣤⣤⣤⠄⣀⠉⣉⣙⠒⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠴⠘⣉⢡⣤⡤⠐⣶⡆⢶⠀⣶⣶⡦
				-- ⣄⢻⣿⣧⠻⠇⠋⠀⠋⠀⢘⣿⢳⣦⣌⠳⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠞⣡⣴⣧⠻⣄⢸⣿⣿⡟⢁⡻⣸⣿⡿⠁
				-- ⠈⠃⠙⢿⣧⣙⠶⣿⣿⡷⢘⣡⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⣷⣝⡳⠶⠶⠾⣛⣵⡿⠋⠀⠀
				-- ⠀⠀⠀⠀⠉⠻⣿⣶⠂⠘⠛⠛⠛⢛⡛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠛⠀⠉⠒⠛⠀⠀⠀⠀⠀
				-- ⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⢸⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				-- ⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⣾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				-- ⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				-- ⠀⠀⠀⠀⠀⠀⢻⡁⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				-- ⠀⠀⠀⠀⠀⠀⠘⡇⠀⠀⠀⠀⠀⠀⠀
				-- ⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				-- ⠀⠀⠀ ⠀⠀⠀⠿]],
				-- 				},
				sections = {
					{
						section = "terminal",
						cmd = "chafa ~/Downloads/shenron-removebg-preview.png --format symbols --symbols vhalf --size 60x25 --stretch; sleep 0.1",
						height = 24,
					},
					{
						{ section = "keys", padding = 1, gap = 1 },
						{ section = "startup" },
					},
				},
			},
		},
		keys = {
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>s",
				function()
					Snacks.scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
			{
				"<leader>z",
				function()
					if zen_active then
						vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
						zen_active = false
					else
						vim.api.nvim_set_hl(0, "Normal", { bg = "#101017" })
						zen_active = true
					end

					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},
			{
				"<leader>Z",
				function()
					Snacks.zen.zoom()
				end,
				desc = "Toggle Zoom",
			},
			{
				"<leader>N",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
			{
				"<leader>gg",
				function()
					Snacks.lazygit.open()
				end,
				desc = "Open Lazygit",
			},
		},
	},
}
