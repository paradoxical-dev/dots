return {
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				max_width = { 100, 0.7 },
				min_width = { 20, 0.2 },
			},
			select = {
				fzf_lua = {
					winopts = {
						height = 0.4,
						width = 0.3,
					},
				},
			},
		},
	},
}
