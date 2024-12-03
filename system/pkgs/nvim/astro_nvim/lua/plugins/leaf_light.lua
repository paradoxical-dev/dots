return {
  "daschw/leaf.nvim",
  config = function()
    local transparent = {
      Normal = { bg = "none" },
      Cursor = { bg = "#000000", fg = "#e1e4dc" },
      NormalNC = { bg = "none" },
      NormalFloat = { link = "Normal" },
      FloatBorder = { link = "Normal" },
      TabLineFill = { link = "Normal" },
      WinBar = { link = "Normal" },
      WinBarNC = { link = "Normal" },
      CursorLineFold = { link = "Normal" },
      CursorLineSign = { link = "Normal" },
      FoldColumn = { bg = "none", fg = "#666666" },
      SignColumn = { link = "Normal" },
      StatusLine = { bg = "none" },
      CursorLine = { bg = "none" },
      Comment = { fg = "#696969" },
    }
    require("leaf").setup {
      theme = "light",
      overrides = transparent,
    }
    vim.cmd.colorscheme "leaf"
  end,
}
