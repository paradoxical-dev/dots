return {
	{
		"matarina/pyrola.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = {
			{
				"<leader>ii",
				function()
					require("pyrola").send_statement_definition()
				end,
				desc = "Send Statement Definition",
			},
			{
				"<leader>is",
				function()
					require("pyrola").send_visual_to_repl()
				end,
				mode = "v",
				desc = "Send Visual To Repl",
			},
			{
				"<leader>iI",
				function()
					require("pyrola").inspect()
				end,
				desc = "Inspect Object",
			},
		},
		event = "BufReadPre",
		build = ":UpdateRemotePlugins",
		-- opts = {
		-- 	kernel_map = {
		-- 		python = "python3",
		-- 		lua = "ilua",
		-- 		javascript = "ijavascript",
		-- 	},
		-- 	split_horizen = false,
		-- 	split_ratio = 0.3,
		-- },
		config = function()
			local pyrola = require("pyrola")
			pyrola.setup({
				kernel_map = {
					python = "python3",
					lua = "ilua",
					javascript = "ijavascript",
				},
				split_horizen = false,
				split_ratio = 0.3,
			})
		end,
	},
}
