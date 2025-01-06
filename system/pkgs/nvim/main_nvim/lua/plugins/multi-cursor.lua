return {
	{
		"mg979/vim-visual-multi",
		event = "BufReadPre",
		config = function()
			vim.g.VM_silent_exit = 1
		end,
	},

	-- {
	-- 	"smoka7/multicursors.nvim",
	-- 	lazy = true,
	-- 	-- event = { "InsertEnter", "ModeChanged" },
	-- 	dependencies = {
	-- 		"nvimtools/hydra.nvim",
	-- 	},
	-- 	cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
	-- 	keys = {
	-- 		{
	-- 			mode = { "v", "n" },
	-- 			"<Leader>m",
	-- 			"<cmd>MCstart<cr>",
	-- 			desc = "Selection For Selected Text or Word Under Cursor",
	-- 		},
	-- 	},
	-- 	opts = {},
	-- },
}
