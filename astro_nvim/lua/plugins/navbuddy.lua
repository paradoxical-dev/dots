return {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    lsp = { auto_attach = true }, -- Enable auto-attach for LSP
  },
  config = function(_, opts)
    require("nvim-navbuddy").setup(opts) -- Use opts passed from `opts` table
    vim.api.nvim_set_keymap("n", "<leader>nn", "<cmd>Navbuddy<cr>", { noremap = true, silent = true })
  end,
}
