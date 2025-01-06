return {
	{
		"ibhagwan/fzf-lua",
		lazy = true,
		keys = {
			-- Search --
			{
				"<leader>ff",
				function()
					require("fzf-lua").files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fo",
				function()
					require("fzf-lua").oldfiles()
				end,
				desc = "Find Recent Files",
			},
			{
				"<leader>fb",
				function()
					require("fzf-lua").buffers()
				end,
				desc = "Find Buffers",
			},
			{
				"<leader>fw",
				function()
					require("fzf-lua").live_grep()
				end,
				desc = "Live Grep",
			},
			{
				"<leader>fy",
				function()
					require("fzf-lua").registers()
				end,
				desc = "Browse Registers",
			},
			{
				"<leader>ft",
				"<cmd>TodoFzfLua<CR>",
				desc = "Search Todo Comments",
			},
			{
				"<leader>fk",
				function()
					require("fzf-lua").keymaps()
				end,
				desc = "Search Keymaps",
			},
			{
				"<leader>fm",
				function()
					require("fzf-lua").manpages()
				end,
				desc = "Search Man Pages",
			},
			{
				"<leader>fh",
				function()
					require("fzf-lua").help_tags()
				end,
				desc = "Search Help Tags",
			},

			-- Git --
			{
				"<leader>gc",
				function()
					require("fzf-lua").git_commits()
				end,
				desc = "Browse Commits",
			},
			{
				"<leader>gb",
				function()
					require("fzf-lua").git_branches()
				end,
				desc = "Browse Branches",
			},
			{
				"<leader>gs",
				function()
					require("fzf-lua").git_status()
				end,
				desc = "Browse Status",
			},

			-- LSP --
			{
				"<leader>ld",
				function()
					require("fzf-lua").diagnostics_document()
				end,
				desc = "Browse Diagnostics",
			},
			{
				"<leader>lD",
				function()
					require("fzf-lua").diagnostics_workspace()
				end,
				desc = "Worksapce Diagnostics",
			},
			{
				"<leader>lr",
				function()
					require("fzf-lua").lsp_references()
				end,
				desc = "References",
			},
			{
				"<leader>lS",
				function()
					require("fzf-lua").lsp_workspace_symbols()
				end,
				desc = "Workspace Symbols",
			},
			{
				"<leader>lG",
				function()
					require("fzf-lua").lsp_definitions()
				end,
				desc = "Browse Definitions",
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			"telescope",
			files = {
				prompt = "   ",
				cwd_prompt = false,
			},
			oldfiles = {
				prompt = "   ",
			},
			buffers = {
				prompt = "   ",
			},
			lsp = {
				prompt = " LSP   ",
				code_actions = {
					prompt = " Code Actions   ",
				},
			},
			git = {
				files = {
					prompt = "   ",
				},
				commits = {
					prompt = "   ",
				},
				branches = {
					prompt = "   ",
				},
				status = {
					prompt = "   ",
				},
			},
			diagnostics = {
				prompt = "   ",
			},
			keymaps = {
				prompt = "   ",
			},
		},
	},
}
