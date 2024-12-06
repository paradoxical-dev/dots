return {
  {
    "dgox16/oldworld.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      local transparent = {
        Normal = { bg = "none" },
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
        LineNr = { fg = "#666666" },
        StatusLine = { bg = "none" },
        Pmenu = { link = "Normal" },
        CursorLine = { link = "Normal" },
        TelescopePreviewNormal = { link = "Normal" },
        TelescopePreviewBorder = { link = "Normal" },
        TelescopeResultsBorder = { link = "Normal" },
        TelescopeResultsNormal = { link = "Normal" },
        TelescopePromptNormal = { link = "Normal" },
        TelescopePromptBorder = { link = "Normal" },
        WhichKeyBorder = { link = "normal" },
      }
      local normal = {
        TabLineFill = { link = "TabLine" },
        WinBar = { link = "TabLine" },
        -- Normal = { link = "CursorLine" },
      }
      require("oldworld").setup {
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          functions = { bold = true },
          keywords = { italic = true },
        },
        highlight_overrides = transparent,
      }
      vim.cmd.colorscheme "oldworld"
    end,
  },
}
