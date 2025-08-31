return {
	{
		"sindrets/diffview.nvim",
		lazy = true,
		keys = {
			{
				"<leader>gD",
				function()
					local Snacks = require("snacks")
					local Job = require("plenary.job")

					local function get_rev_list()
						local rl = Job:new({
							command = "git",
							args = { "rev-list", "--first-parent", "HEAD" },
						}):sync()

						for i, line in ipairs(rl) do
							rl[i] = line:sub(1, 7)
						end

						return rl
					end

					local function get_commits()
						return Job:new({
							command = "git",
							args = { "log", "--all", "--pretty=format:%h|%p|%s" },
						}):sync()
					end

					local function get_branches()
						local map = {}

						local branches = Job:new({
							command = "git",
							args = { "for-each-ref", "--format=%(refname:short)" },
						}):sync()

						for _, branch in ipairs(branches) do
							local revs = Job:new({
								command = "git",
								args = { "rev-list", "--first-parent", branch },
							}):sync()

							for _, sha in ipairs(revs) do
								sha = sha:sub(1, 7)
								map[sha] = map[sha] or {}
								table.insert(map[sha], branch)
							end
						end

						return map
					end

					local function get_tag_map()
						local map = {}
						Job:new({
							command = "git",
							args = { "show-ref", "--tags" },
							on_stdout = function(_, line)
								local hash, ref = line:match("([^%s]+)%s+([^%s]+)")
								if hash and ref then
									hash = hash:sub(1, 7)
									local tag = ref:match("refs/tags/(.+)")
									map[hash] = tag
								end
							end,
						}):sync()
						return map
					end

					local function get_head_map()
						local map = {}
						local rev_list = get_rev_list()
						for i, sha in ipairs(rev_list) do
							if i == 1 then
								map[sha] = "HEAD"
							else
								map[sha] = "HEAD~" .. (i - 1)
							end
						end
						return map
					end

					local function get_items()
						local commits = get_commits()
						local rel_map = get_head_map()
						local branch_map = get_branches()
						local tag_map = get_tag_map()
						local items = {}

						for _, line in ipairs(commits) do
							local hash, parents, message = line:match("([^|]+)|([^|]*)|(.+)")
							local parent1, parent2 = parents:match("(%w+)%s*(%w*)")
							local is_merge = parent2 and parent2 ~= ""

							local rel = rel_map[hash] or ""
							local branches = branch_map[hash] or {}
							local tag = tag_map[hash]

							local branch_str = ""
							local full_branch_str = ""
							if #branches > 0 then
								if is_merge then
									local source = branch_map[parent2]
									local target = branch_map[parent1]
									local source_branch = source and source[1] or "?"
									local target_branch = target and target[1] or "?"

									branch_str = "[" .. source_branch .. " -> " .. target_branch .. "]"
									full_branch_str = branch_str
								else
									full_branch_str = "[" .. table.concat(branches, ", ") .. "]"
									local origin = branches[1]
									local width = vim.fn.strdisplaywidth(origin)
									if width >= 18 then
										origin = origin:sub(1, 21) .. "..."
									end
									if #branches > 1 then
										branch_str = "[" .. origin .. "+" .. "]"
									else
										branch_str = "[" .. (origin or "") .. "]"
									end
								end
							end

							table.insert(items, {
								text = hash
									.. " "
									.. message
									.. " "
									.. full_branch_str
									.. " "
									.. rel
									.. " "
									.. (tag or ""),
								hash = "󰜘 " .. hash,
								commit = hash,
								rel = rel,
								tag = tag or "",
								full_branch_str = full_branch_str,
								branch = branch_str,
								message = message,
							})
						end
						return items
					end

					local function open_picker()
						local commits = {}
						local items = get_items()

						local function format_line(item)
							return {
								{ string.format("%-14s", item.hash), "SnacksPickerGitCommit" },
								{ string.format("%-12s", item.rel or ""), "SnacksPickerComment" },
								{ string.format("%-30s", (item.branch or ""):sub(1, 30)), "SnacksPickerIdx" },
								{ item.message, "SnacksPickerBold" },
							}
						end

						local function open_diff()
							if #commits == 1 then
								vim.cmd("DiffviewOpen " .. commits[1])
							elseif #commits == 2 then
								vim.cmd("DiffviewOpen " .. commits[1] .. ".." .. commits[2])
							else
								vim.cmd("DiffviewOpen")
							end
						end

						local function pick_commit(prompt)
							local commit_picked = false
							Snacks.picker({
								title = prompt,
								items = items,
								format = format_line,
								layout = "telescope",
								preview = function(ctx)
									local item = ctx.item

									local lines = {
										"Relative: " .. (item.rel or "N/A"),
										"Branches: " .. (item.full_branch_str or "?"),
										"Tag: " .. (item.tag or ""),
									}

									local cmd = {
										"git",
										"-c",
										"delta." .. vim.o.background .. "=true",
										"show",
										item.commit,
									}
									local pathspec = item.files or item.file
									pathspec = type(pathspec) == "table" and pathspec or { pathspec }
									if #pathspec > 0 then
										cmd[#cmd + 1] = "--"
										vim.list_extend(cmd, pathspec)
									end

									Job:new({
										command = cmd[1],
										args = vim.list_slice(cmd, 2),
										on_exit = function(j)
											vim.schedule(function()
												local git_lines = j:result()
												vim.list_extend(lines, git_lines)
												local ns = vim.api.nvim_create_namespace("diff_picker_preview")
												ctx.preview:set_lines(lines)

												-- set highlight for custom metadata
												vim.api.nvim_buf_set_extmark(ctx.preview.win.buf, ns, 0, 0, {
													end_col = 9,
													hl_group = "gitKeyword",
												})
												vim.api.nvim_buf_set_extmark(ctx.preview.win.buf, ns, 0, 10, {
													end_col = #lines[1],
													hl_group = "Comment",
												})

												vim.api.nvim_buf_set_extmark(ctx.preview.win.buf, ns, 1, 0, {
													end_col = 9,
													hl_group = "gitKeyword",
												})
												vim.api.nvim_buf_set_extmark(ctx.preview.win.buf, ns, 1, 10, {
													end_col = #lines[2],
													hl_group = "Type",
												})

												vim.api.nvim_buf_set_extmark(ctx.preview.win.buf, ns, 2, 0, {
													end_col = 5,
													hl_group = "gitKeyword",
												})
												vim.api.nvim_buf_set_extmark(ctx.preview.win.buf, ns, 2, 5, {
													end_col = #lines[3],
													hl_group = "Macro",
												})
												ctx.preview:highlight({ ft = "git" })
											end)
										end,
									}):start()
								end,
								confirm = function(picker, item)
									commit_picked = true
									table.insert(commits, item.commit)
									picker:close()
									if #commits < 2 then
										pick_commit("Select next commit")
									else
										open_diff()
									end
								end,
								on_close = vim.schedule_wrap(function()
									if not commit_picked and #commits > 0 then
										open_diff()
									end
								end),
							})
						end

						pick_commit("Select first commit")
					end

					local open = vim.fn.confirm("Browse commits?", "&Yes\n&No", 1)
					if open == 1 then
						open_picker()
					else
						vim.cmd("DiffviewOpen")
					end
				end,
				desc = "Diff View",
			},
			{
				"<leader>gF",
				function()
					vim.api.nvim_feedkeys(":DiffviewFileHistory ", "n", false)
					-- 	vim.ui.input({ prompt = "Paths and/or options", completion = "command" }, function(target)
					-- 		if not target then
					-- 			return
					-- 		end
					-- 		if target == "" then
					-- 			vim.cmd("DiffviewFileHistory %")
					-- 		else
					-- 			vim.cmd("DiffviewFileHistory " .. target)
					-- 		end
					-- 	end)
				end,
				desc = "Diff View File Hist",
			},
		},
	},
}
