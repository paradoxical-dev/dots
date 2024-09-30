return {
  {
    "catppuccin/nvim", name = "catppuccin", priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = 'mocha',
        transparent_background = true,
        highlight_overrides = {
          all = function (colors)
            return {
              CursorLine = {bg = 'none'}
            }
          end,
        },
      })
      -- vim.cmd.colorscheme('catppuccin')
    end
  }
}
