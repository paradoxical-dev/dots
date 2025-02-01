return {
	{
		"Exafunction/codeium.nvim",
		event = "InsertEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
				virtual_text = {
					enabled = true,
					manual = false,
					filetypes = { dashboard = false, typr = false, snacks_picker_input = false },
					idle_delay = 25,
					key_bindings = {
						accept = "<C-g>",
						next = "<C-]>",
						prev = "<C-[",
						clear = "<C-x>",
					},
				},
			})
		end,
	},
}
