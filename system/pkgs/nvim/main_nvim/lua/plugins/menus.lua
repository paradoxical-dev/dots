return {
	{
		"nvzone/menu",
		lazy = true,
		dependencies = { "nvzone/volt" },
		keys = {
			{
				"<C-e>",
				function()
					require("menu").open("default")
					vim.api.nvim_set_hl(0, "ExBlack2Bg", { link = "NormalFloat" })
					vim.api.nvim_set_hl(0, "ExBlack2Border", { link = "FloatBorder" })
				end,
				desc = "Open Menu",
			},
		},
	},
}
