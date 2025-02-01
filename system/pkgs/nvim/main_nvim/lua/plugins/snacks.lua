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

			picker = {
				enabled = true,
				prompt = "   ",
				layout = {
					-- layout = {
					-- 	backdrop = false,
					-- 	row = 1,
					-- 	width = 0.4,
					-- 	min_width = 80,
					-- 	height = 0.5,
					-- 	min_height = 30,
					-- 	box = "vertical",
					-- 	border = "rounded",
					-- 	title = "{title} {live} {flags}",
					-- 	title_pos = "center",
					-- 	{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
					-- 	{ win = "input", height = 1, border = "bottom" },
					-- 	{ win = "list", border = "none" },
					-- },

					preview = false,
					layout = {
						backdrop = false,
						row = 1,
						width = 0.4,
						min_width = 80,
						height = 0.4,
						border = "none",
						box = "vertical",
						{ win = "preview", title = "{preview}", border = "rounded", height = 0.7 },
						{
							win = "input",
							height = 1,
							border = "rounded",
							title = "{title} {live} {flags}",
							title_pos = "center",
						},
						{ win = "list", border = "hpad" },
					},
				},
			},
		},
		keys = {
			-- STANDARD PICKERS --
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Search Files",
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Search Buffers",
			},
			{
				"<leader>fw",
				function()
					Snacks.picker.grep()
				end,
				desc = "Live Grep",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep_buffers()
				end,
				desc = "Grep Open Buffers",
			},
			{
				"<leader>fk",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "Search Keymaps",
			},
			{
				"<leader>fm",
				function()
					Snacks.picker.man()
				end,
				desc = "Browse Man Pages",
			},
			{
				"<leader>ft",
				function()
					Snacks.picker.todo_comments()
				end,
				desc = "Search Todo Comments",
			},
			{
				"<leader>fo",
				function()
					Snacks.picker.recent()
				end,
				desc = "Search Recent Files",
			},
			{
				'<leader>f"',
				function()
					Snacks.picker.registers()
				end,
				desc = "Browse Registers",
			},
			{
				"<leader>fy",
				function()
					Snacks.picker.cliphist()
				end,
				desc = "Browse Cliphist",
			},
			{
				"<leader>fc",
				function()
					Snacks.picker.command_history({
						finder = "vim_history",
						name = "cmd",
						format = "text",
						preview = "none",
						layout = {
							preset = "vscode",
						},
						confirm = { "copy", "close" },
						formatters = { text = { ft = "vim" } },
					})
				end,
				desc = "Browse Command History",
			},
			{
				"<leader>fh",
				function()
					Snacks.picker.help()
				end,
				desc = "Browse Help",
			},
			{
				"<leader>fi",
				function()
					Snacks.picker.highlights()
				end,
				desc = "Browse Highlights",
			},
			{
				"<leader>fp",
				function()
					Snacks.picker.lazy()
				end,
				desc = "Browse Plugins",
			},
			{
				"<leader>fq",
				function()
					Snacks.picker.qflist()
				end,
				desc = "Browse Quickfix List",
			},
			{
				"<leader>fP",
				function()
					Snacks.picker.projects()
				end,
				desc = "Browse Projects",
			},
			{
				"<leader>fl",
				function()
					Snacks.picker.lines()
				end,
				desc = "Grep Lines in Current Buffer",
			},
			{
				"<leader>fa",
				function()
					Snacks.picker.autocmds()
				end,
				desc = "Browse Autocmds",
			},
			{
				"<leader>fu",
				function()
					Snacks.picker.undo({
						layout = {
							preview = true,
							layout = {
								backdrop = false,
								width = 0.5,
								min_width = 80,
								height = 0.3,
								min_height = 20,
								row = 3,
								box = "vertical",
								border = "rounded",
								title = "{title} {live} {flags}",
								title_pos = "center",
								{ win = "preview", title = "{preview}", height = 0.7, border = "top" },
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
						},
					})
				end,
				desc = "Browse Undo History",
			},

			-- GIT PICKERS --
			{
				"<leader>gb",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Browse Branches",
			},
			{
				"<leader>gd",
				function()
					Snacks.picker.git_diff({
						finder = "git_diff",
						format = "file",
						preview = "preview",
						layout = {
							preview = true,
							reverse = true,
							layout = {
								box = "horizontal",
								backdrop = false,
								width = 0.8,
								height = 0.9,
								border = "none",
								{
									box = "vertical",
									{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
									{
										win = "input",
										height = 1,
										border = "rounded",
										title = "{title} {live} {flags}",
										title_pos = "center",
									},
								},
								{
									win = "preview",
									title = "{preview:Preview}",
									width = 0.6,
									border = "rounded",
									title_pos = "center",
								},
							},

							-- preview = true,
							-- layout = {
							-- 	backdrop = false,
							-- 	width = 0.5,
							-- 	row = 5,
							-- 	min_width = 80,
							-- 	height = 0.6,
							-- 	min_height = 30,
							-- 	box = "vertical",
							-- 	border = "rounded",
							-- 	title = "{title} {live} {flags}",
							-- 	title_pos = "center",
							-- 	{ win = "preview", title = "{preview}", height = 0.8, border = "top" },
							-- 	{ win = "input", height = 1, border = "bottom" },
							-- 	{ win = "list", border = "none" },
							-- },
						},
					})
				end,
				desc = "Browse Diff",
			},
			{
				"<leader>gl",
				function()
					Snacks.picker.git_log({
						finder = "git_log",
						format = "git_log",
						preview = "git_show",
						confirm = "git_checkout",
						layout = {
							reverse = true,
							preview = true,
							layout = {
								preview = true,
								box = "horizontal",
								backdrop = false,
								width = 0.8,
								height = 0.9,
								border = "none",
								{
									box = "vertical",
									{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
									{
										win = "input",
										height = 1,
										border = "rounded",
										title = "{title} {live} {flags}",
										title_pos = "center",
									},
								},
								{
									win = "preview",
									title = "{preview:Preview}",
									width = 0.45,
									border = "rounded",
									title_pos = "center",
								},
							},
						},
					})
				end,
				desc = "Browse Logs",
			},
			{
				"<leader>gf",
				function()
					Snacks.picker.git_log_file({
						finder = "git_log",
						format = "git_log",
						preview = "git_show",
						current_file = true,
						follow = true,
						confirm = "git_checkout",
						layout = {
							reverse = true,
							preview = true,
							layout = {
								preview = true,
								box = "horizontal",
								backdrop = false,
								width = 0.8,
								height = 0.9,
								border = "none",
								{
									box = "vertical",
									{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
									{
										win = "input",
										height = 1,
										border = "rounded",
										title = "{title} {live} {flags}",
										title_pos = "center",
									},
								},
								{
									win = "preview",
									title = "{preview:Preview}",
									width = 0.45,
									border = "rounded",
									title_pos = "center",
								},
							},
						},
					})
				end,
				desc = "Current File Logs",
			},
			{
				"<leader>gL",
				function()
					Snacks.picker.git_log_line({
						finder = "git_log",
						format = "git_log",
						preview = "git_show",
						current_line = true,
						follow = true,
						confirm = "git_checkout",
						layout = {
							reverse = true,
							preview = true,
							layout = {
								preview = true,
								box = "horizontal",
								backdrop = false,
								width = 0.8,
								height = 0.9,
								border = "none",
								{
									box = "vertical",
									{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
									{
										win = "input",
										height = 1,
										border = "rounded",
										title = "{title} {live} {flags}",
										title_pos = "center",
									},
								},
								{
									win = "preview",
									title = "{preview:Preview}",
									width = 0.45,
									border = "rounded",
									title_pos = "center",
								},
							},
						},
					})
				end,
				desc = "Current Line Logs",
			},
			{
				"<leader>gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git Status",
			},
			{
				"<leader>gS",
				function()
					Snacks.picker.git_stash()
				end,
				desc = "Git Stash",
			},

			-- LSP PICKERS --
			{
				"<leader>ld",
				function()
					Snacks.picker.diagnostics_buffer({
						layout = {
							preview = true,
							layout = {
								backdrop = false,
								width = 0.5,
								min_width = 80,
								height = 0.3,
								min_height = 20,
								row = 3,
								box = "vertical",
								border = "rounded",
								title = "{title} {live} {flags}",
								title_pos = "center",
								{ win = "preview", title = "{preview}", height = 0.7, border = "top" },
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
						},
					})
				end,
				desc = "Buffer Diagnostics",
			},
			{
				"<leader>lD",
				function()
					Snacks.picker.diagnostics({
						layout = {
							preview = true,
							layout = {
								backdrop = false,
								width = 0.5,
								min_width = 80,
								height = 0.3,
								min_height = 20,
								row = 3,
								box = "vertical",
								border = "rounded",
								title = "{title} {live} {flags}",
								title_pos = "center",
								{ win = "preview", title = "{preview}", height = 0.7, border = "top" },
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
						},
					})
				end,
				desc = "Workspace Diagnostics",
			},
			{
				"<leader>lr",
				function()
					Snacks.picker.lsp_references({
						layout = {
							preview = true,
							layout = {
								preview = true,
								backdrop = false,
								width = 0.5,
								min_width = 80,
								height = 0.3,
								min_height = 20,
								row = 3,
								box = "vertical",
								border = "rounded",
								title = "{title} {live} {flags}",
								title_pos = "center",
								{ win = "preview", title = "{preview}", height = 0.7, border = "top" },
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
						},
					})
				end,
				desc = "Search References",
			},
			{
				"<leader>lS",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "Workspace Symbols",
			},
			{
				"<leader>li",
				function()
					Snacks.picker.lsp_implementations({
						layout = {
							preview = true,
							layout = {
								preview = true,
								backdrop = false,
								width = 0.5,
								min_width = 80,
								height = 0.3,
								min_height = 20,
								row = 3,
								box = "vertical",
								border = "rounded",
								title = "{title} {live} {flags}",
								title_pos = "center",
								{ win = "preview", title = "{preview}", height = 0.7, border = "top" },
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
						},
					})
				end,
				desc = "Browse Implementations",
			},
			{
				"<leader>lG",
				function()
					Snacks.picker.lsp_definitions({
						layout = {
							preview = true,
							layout = {
								preview = true,
								backdrop = false,
								width = 0.5,
								min_width = 80,
								height = 0.3,
								min_height = 20,
								row = 3,
								box = "vertical",
								border = "rounded",
								title = "{title} {live} {flags}",
								title_pos = "center",
								{ win = "preview", title = "{preview}", height = 0.7, border = "top" },
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
						},
					})
				end,
				desc = "Browse Definitions",
			},
			{
				"<leader>la",
				function()
					Snacks.picker.lsp_declarations({
						layout = {
							preview = true,
							layout = {
								preview = true,
								backdrop = false,
								width = 0.5,
								min_width = 80,
								height = 0.3,
								min_height = 20,
								row = 3,
								box = "vertical",
								border = "rounded",
								title = "{title} {live} {flags}",
								title_pos = "center",
								{ win = "preview", title = "{preview}", height = 0.7, border = "top" },
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
						},
					})
				end,
				desc = "Browse Declarations",
			},
			{
				"<leader>lt",
				function()
					Snacks.picker.lsp_type_definitions({
						layout = {
							preview = true,
							layout = {
								preview = true,
								backdrop = false,
								width = 0.5,
								min_width = 80,
								height = 0.3,
								min_height = 20,
								row = 3,
								box = "vertical",
								border = "rounded",
								title = "{title} {live} {flags}",
								title_pos = "center",
								{ win = "preview", title = "{preview}", height = 0.7, border = "top" },
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
						},
					})
				end,
				desc = "Browse Type Definitions",
			},

			-- EXPLORER --
			{
				"<leader>o",
				function()
					Snacks.picker.explorer({
						finder = "explorer",
						sort = { fields = { "sort" } },
						tree = true,
						supports_live = true,
						follow_file = true,
						focus = "list",
						auto_close = false,
						jump = { close = false },
						layout = {
							preview = false,
							layout = {
								backdrop = false,
								width = 25,
								min_width = 20,
								height = 0,
								position = "left",
								border = "none",
								box = "vertical",
								{
									win = "input",
									height = 1,
									border = "rounded",
									wo = {
										winhighlight = "NormalFloat:Normal,FloatTitle:SnacksPickerInputTitle,CursorLine:SnacksPickerInputCursorLine,FloatBorder:SnacksIndent,FloatFooter:SnacksPickerInputFooter",
									},
									title = "{title} {live} {flags}",
									title_pos = "center",
								},
								{
									win = "list",
									border = "none",
									wo = {
										winhighlight = "FloatTitle:SnacksPickerListTitle,FloatBorder:SnacksPickerListBorder,FloatFooter:SnacksPickerListFooter,CursorLine:SnacksPickerListCursorLine,NormalFloat:Normal,SnacksPickerTree:SnacksIndent",
										statuscolumn = "",
										signcolumn = "no",
										conceallevel = 3,
										number = false,
										relativenumber = false,
										winbar = "",
									},
								},
								{
									win = "preview",
									title = "{preview}",
									height = 0.4,
									border = "top",
								},
							},
						},
						formatters = { file = { filename_only = true } },
						matcher = { sort_empty = true },
						win = {
							list = {
								keys = {
									["<BS>"] = "explorer_up",
									["a"] = "explorer_add",
									["d"] = "explorer_del",
									["r"] = "explorer_rename",
									["c"] = "explorer_copy",
									["m"] = "explorer_move",
									["y"] = "explorer_yank",
									["<c-c>"] = "explorer_cd",
									["."] = "explorer_focus",
								},
								wo = {
									winhighlight = "NormalFloat:Normal",
								},
								b = {
									filetype = "snacks-explorer",
								},
							},
							wo = {
								winhighlight = "NormalFloat:Normal",
							},
						},
					})
				end,
				desc = "File Explorer",
			},

			-- SCRATCH --
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

			-- ZEN MODE --
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
