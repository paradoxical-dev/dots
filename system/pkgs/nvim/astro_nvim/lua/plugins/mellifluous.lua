local transparent = {
  Normal = { bg = "none" },
  TermCursor = { bg = "#f0f0f0", fg = "#000000" },
  NormalNC = { bg = "none" },
  NormalFloat = { link = "Normal" },
  FloatBorder = { link = "Normal" },

  WinBar = { link = "Normal" },
  WinBarNC = { link = "Normal" },
  WinSeparator = { fg = "#404040" },

  TabLineFill = { link = "Normal" },
  LineNr = { fg = "#454545" },
  LineNrAbove = { fg = "#454545" },
  LineNrBelow = { fg = "#454545" },
  CursorLineNr = { fg = "#8ea4a2" },
  CursorLineFold = { link = "Normal" },
  CursorLineSign = { link = "Normal" },
  FoldColumn = { bg = "none", fg = "#666666" },
  SignColumn = { link = "Normal" },
  StatusLine = { bg = "none" },
  CursorLine = { bg = "none" },

  Comment = { fg = "#696969" },

  CmpDocumentation = { bg = "none" },
  CmpDocumentationBorder = { bg = "none" },

  NeoTreeEndOfBuffer = { link = "Normal" },
  NeoTreeStatusLine = { bg = "none", fg = "#aba8a8" },
  NeoTreeTabInactive = { bg = "none", fg = "#aba8a8" },
  NeoTreeTabSeparatorInactive = { bg = "none", fg = "#202020" },
  NeoTreeSignColumn = { bg = "none", fg = "#aba8a8" },
  NeoTreePopup = { bg = "none", fg = "#aba8a8" },
  NeoTreePopupBorder = { link = "Normal" },
  NeoTreeNormal = { bg = "none", fg = "#aba8a8" },
  NeoTreeNormalNC = { bg = "none", fg = "#aba8a8" },
  NeoTreeWinSeparator = { link = "WinSeparator" },

  TelescopePreviewNormal = { link = "Normal" },
  TelescopeResultsNormal = { link = "TelescopePreviewNormal" },
  TelescopePromptNormal = { link = "TelescopePreviewNormal" },
  TelescopePreviewBorder = { link = "Normal" },
  TelescopeResultsBorder = { link = "TelescopePreviewBorder" },
  TelescopePromptBorder = { link = "TelescopePreviewBorder" },

  snacksDashboardDir = { link = "Comment" },

  NotifyBackground = { link = "Normal" },

  RenderMarkdownCode = { bg = "#232323" },
}

return {
  {
    "ramojus/mellifluous.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      colorset = "kanagawa_dragon",
      highlight_overrides = {
        dark = function(highlighter, colors)
          for key, value in pairs(transparent) do
            highlighter.set(key, value)
          end
        end,
      },
    },
    config = function(_, opts)
      require("mellifluous").setup(opts)
      vim.cmd.colorscheme "mellifluous"
    end,
  },
}
