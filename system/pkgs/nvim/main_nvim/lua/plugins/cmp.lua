return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",

			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
			"saadparwaiz1/cmp_luasnip",

			"onsails/lspkind.nvim", -- for symbols
		},
		config = function()
			local luasnip = require("luasnip")
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local lspkind = require("lspkind")
			require("luasnip.loaders.from_vscode").lazy_load()
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "luasnip", keyword_length = 1 },
					{ name = "buffer", keyword_length = 1 },
					{ name = "command" },
					{ name = "codeium" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- INFO: Super tab movement for faster cmp nav
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({
									select = true,
								})
							end
						else
							fallback()
						end
					end),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				-- for symbols
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 50,
						ellipsis_char = "...",
						smybol_map = { Codeium = "" },
					}),
				},
			})
		end,
	},
}
