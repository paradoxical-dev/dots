return {
	{
		"ibhagwan/fzf-lua",
		lazy = true,
    keys = {
      { "<leader>ff", function() require('fzf-lua').files() end, desc = "Find Files" },
      { "<leader>fo", function() require('fzf-lua').oldfiles() end, desc = "Find Recent Files" },
      { "<leader>fb", function() require('fzf-lua').buffers() end, desc = "Find Buffers" },
      { "<leader>fw", function() require('fzf-lua').live_grep() end, desc = "Live Grep" },
      { "<leader>fy", function() require('fzf-lua').registers() end, desc = "Browse Registers" },

      { "<leader>gc", function() require('fzf-lua').git_commits() end, desc = "Browse Commits" },
      { "<leader>gb", function() require('fzf-lua').git_branches() end, desc = "Browse Branches" },
    },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { "telescope" },
	},
}
