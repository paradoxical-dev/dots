return {
	{
		-- OLDWORLD
		-- "dgox16/oldworld.nvim",
		-- lazy = false,
		-- priority = 1000,
		-- config = function()
		-- 	require("oldworld").setup({
		-- 		variant = "oled",
		-- 		highlight_overrides = {
		-- 			-- UI
		-- 			WinBar = { bg = "none" },
		-- 			WinBarNC = { bg = "none" },
		--
		-- 			-- GITSIGNS
		-- 			GitSignsAdd = { fg = "#90b99f" },
		-- 			GitSignsChange = { fg = "#e6b99d" },
		-- 			GitSignsDelete = { fg = "#ea83a5" },
		-- 			["GitSignsBlameColor.2ee"] = { fg = "#85b5ba" },
		-- 			["GitSignsBlameColor.33a"] = { link = "Keyword" },
		-- 			["GitSignsBlameColor.4ee"] = { fg = "#85b5ba" },
		-- 			["GitSignsBlameColor.5d7"] = { link = "Number" },
		-- 			["GitSignsBlameColor.610"] = { link = "Type" },
		-- 			["GitSignsBlameColor.73e"] = { link = "Function" },
		-- 			["GitSignsBlameColor.811"] = { link = "Type" },
		-- 			["GitSignsBlameColor.c3b"] = { link = "String" },
		-- 			["GitSignsBlameColor.feb"] = { link = "String" },
		--
		-- 			-- STATUS LINE
		-- 			HeirlineNormal = { fg = "#e29eca", bg = "#e29eca" },
		-- 			HeirlineVisual = { fg = "#ACA1CF", bg = "#ACA1CF" },
		-- 			HeirlineInsert = { fg = "#90b99f", bg = "#90b99f" },
		-- 			HeirlineCommand = { fg = "#F5a991", bg = "#F5a991" },
		-- 			HeirlineTerminal = { fg = "#90b99f", bg = "#90b99f" },
		-- 			HeirlineReplace = { fg = "#92a2d5", bg = "#92a2d5" },
		-- 			HeirlineInactive = { fg = "#777777", bg = "#777777" },
		-- 		},
		-- 	})
		-- 	vim.cmd("colorscheme oldworld")
		-- end,

		-- ROSE PINE
		{
			"rose-pine/neovim",
			lazy = false,
			priority = 1000,
			config = function()
				require("rose-pine").setup({
					variant = "main",
					styles = {
						italic = false,
						transparency = true,
					},
					palette = {
						main = {
							-- base = "#0d0d0d",
							-- mantle = "#1c1c21",
							-- crust = "#151517",
						},
					},
					highlight_groups = {
						-- UI
						WinBar = { bg = "none" },
						WinBarNC = { bg = "none" },
						NormalFloat = { bg = "base" },
						FloatBorder = { bg = "base", fg = "base" },
						FloatTitle = { bg = "#2b3435", fg = "foam", italic = true },
						StatusLine = { bg = "none" },
						StatusLineTerm = { bg = "none" },
						StatusLineTermNC = { bg = "none" },
						LineNr = { fg = "text", bold = true },
						LineNrAbove = { fg = "muted" },
						LineNrBelow = { fg = "muted" },
						EndOfBuffer = { fg = "#000000" },

						-- SYNTAX
						Keyword = { italic = true },
						["@variable"] = { bold = true },
						["@property"] = { fg = "#d2cbe7" },
						Comment = { fg = "muted", italic = true },

						-- STATUS
						HeirlineNormal = { fg = "love", bg = "love" },
						HeirlineVisual = { fg = "iris", bg = "iris" },
						HeirlineInsert = { fg = "foam", bg = "foam" },
						HeirlineCommand = { fg = "gold", bg = "gold" },
						HeirlineTerminal = { fg = "rose", bg = "rose" },
						HeirlineReplace = { fg = "pine", bg = "pine" },
						HeirlineInactive = { fg = "#777777", bg = "#777777" },

						-- CMP
						CmpItemKind = { bg = "love", fg = "base" },
						CmpItemKindConstructor = { bg = "love", fg = "base" },
						CmpItemKindTypeParameter = { bg = "love", fg = "base" },
						CmpItemKindOperator = { bg = "love", fg = "base" },
						CmpItemKindEvent = { bg = "love", fg = "base" },
						CmpItemKindMethod = { bg = "love", fg = "base" },
						CmpItemKindStruct = { bg = "love", fg = "base" },
						CmpItemKindEnum = { bg = "iris", fg = "base" },
						CmpItemKindFile = { bg = "iris", fg = "base" },
						CmpItemKindField = { bg = "iris", fg = "base" },
						CmpItemKindUnit = { bg = "iris", fg = "base" },
						CmpItemKindKeyword = { bg = "iris", fg = "base" },
						CmpItemKindVariable = { bg = "iris", fg = "base" },
						CmpItemKindText = { bg = "foam", fg = "base" },
						CmpItemKindInterface = { bg = "foam", fg = "base" },
						CmpItemKindClass = { bg = "foam", fg = "base" },
						CmpItemKindDefault = { bg = "foam", fg = "base" },
						CmpItemKindProperty = { bg = "foam", fg = "base" },
						CmpItemKindColor = { bg = "rose", fg = "base" },
						CmpItemKindReference = { bg = "rose", fg = "base" },
						CmpItemKindEnumMember = { bg = "rose", fg = "base" },
						CmpItemKindFolder = { bg = "rose", fg = "base" },
						CmpItemKindSnippet = { bg = "rose", fg = "base" },
						CmpItemKindValue = { bg = "pine", fg = "base" },
						CmpItemKindConstant = { bg = "pine", fg = "base" },
						CmpItemKindCopilot = { bg = "pine", fg = "base" },
						CmpItemKindModule = { bg = "pine", fg = "base" },
						CmpItemKindFunction = { bg = "pine", fg = "base" },
						CmpItemKindFunctionDefault = { bg = "pine", fg = "base" },

						-- SNACKS
						SnacksIndent = { fg = "base" },
						SnacksIndentChunk = { fg = "foam" },
						SnacksDashboardDesc = { fg = "muted", bold = true },
						SnacksDashboardIcon = { fg = "muted", bold = true, italic = true },
						SnacksDashboardKey = { fg = "muted", bold = true },
						SnacksDashboardFooter = { fg = "foam", italic = true },

						-- WHICHKEY
						WhichKeyBorder = { link = "FloatBorder" },
						WhichKeyDesc = { fg = "text" },
						WhichKeyGroup = { fg = "foam", italic = true },

						-- LVIMSPACE
						LvimSpaceTitle = { link = "FloatTitle" },
						LvimSpaceSign = { fg = "foam" },
						LvimSpaceNormal = { bg = "base" },
						LvimSpaceInput = { bg = "base", fg = "none" },
						-- LvimSpaceCursor = { bg = "none" },
						LvimSpaceInfo = { fg = "rose", bg = "base" },
						LvimSpacePrompt = { fg = "foam", bg = "base" },
					},
				})
				vim.cmd("colorscheme rose-pine")
			end,
		},

		-- CUSTOM ROSE PINE
		-- {
		-- 	"catppuccin/nvim",
		-- 	lazy = false,
		-- 	priority = 1000,
		-- 	opts = {
		-- 		flavour = "mocha",
		-- 		transparent_background = true,
		-- 		color_overrides = {
		-- 			mocha = {
		-- 				rosewater = "#f6c177",
		-- 				flamingo = "#ea9a97",
		-- 				pink = "#ff87a7",
		-- 				mauve = "#c4a7e7",
		-- 				red = "#e86a88",
		-- 				maroon = "#ce717a",
		-- 				peach = "#f4b57d",
		-- 				yellow = "#f7c98c",
		-- 				green = "#31748f",
		-- 				teal = "#7bbec7",
		-- 				sky = "#9ccfd8",
		-- 				sapphire = "#5a99a3",
		-- 				blue = "#8bc7cf",
		-- 				lavender = "#d2cbe7",
		-- 				text = "#cdd6f4",
		-- 				subtext1 = "#bac2de",
		-- 				subtext0 = "#a6adc8",
		-- 				overlay2 = "#9399b2",
		-- 				overlay1 = "#7f849c",
		-- 				overlay0 = "#6c7086",
		-- 				surface2 = "#585b70",
		-- 				surface1 = "#45475a",
		-- 				surface0 = "#313244",
		-- 				base = "#0d0d0d",
		-- 				mantle = "#1c1c21",
		-- 				crust = "#151517",
		-- 			},
		-- 		},
		-- 		highlight_overrides = {
		-- 			mocha = function(c)
		-- 				return {
		-- 					-- STATUS
		-- 					HeirlineNormal = { fg = c.pink, bg = c.pink },
		-- 					HeirlineVisual = { fg = c.mauve, bg = c.mauve },
		-- 					HeirlineInsert = { fg = c.sku, bg = c.sky },
		-- 					HeirlineCommand = { fg = c.peach, bg = c.peach },
		-- 					HeirlineTerminal = { fg = c.yellow, bg = c.yellow },
		-- 					HeirlineReplace = { fg = c.red, bg = c.red },
		-- 					HeirlineInactive = { fg = "#777777", bg = "#777777" },
		--
		-- 					String = { fg = c.yellow },
		-- 					Keyword = { fg = c.green },
		-- 					["@keyword.function"] = { fg = c.green },
		-- 					["@keyword.return"] = { fg = c.green },
		--
		-- 					SnacksIndent = { fg = c.mantle },
		-- 					SnacksIndentChunk = { fg = c.blue },
		-- 				}
		-- 			end,
		-- 		},
		-- 	},
		-- 	config = function(_, opts)
		-- 		require("catppuccin").setup(opts)
		-- 		vim.cmd("colorscheme catppuccin")
		-- 	end,
		-- },
	},
}
