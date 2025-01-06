return {
	{
		"rmagatti/goto-preview",
		event = { "BufReadPre", "LspAttach" },
		keys = {
			{
				"<leader>lg",
				function()
					require("goto-preview").goto_preview_definition()
				end,
				desc = "Goto Preview Definition",
			},
		},
		config = function()
			require("goto-preview").setup({})
		end,
	},
}
