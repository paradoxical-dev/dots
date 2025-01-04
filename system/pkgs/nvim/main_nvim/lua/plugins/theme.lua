return {
	{
		"paradoxical-dev/color-compiler.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("color-compiler").load("burst")
		end,
	},
}
