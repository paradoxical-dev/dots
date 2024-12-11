local base_transparent = { bg = "none" }
local transparent = {
  Normal = { bg = "none" },
  TermCursor = { bg = "#f0f0f0", fg = "#000000" },
  NormalNC = { bg = "none" },
  NormalFloat = base_transparent,
  FloatBorder = base_transparent,

  WinBar = base_transparent,
  WinBarNC = base_transparent,
  WinSeparator = { fg = "#404040" },

  TabLineFill = base_transparent,
  LineNr = { fg = "#454545" },
  LineNrAbove = { fg = "#454545" },
  LineNrBelow = { fg = "#454545" },
  CursorLineNr = { fg = "#8ea4a2" },
  CursorLineFold = base_transparent,
  CursorLineSign = base_transparent,
  FoldColumn = { bg = "none", fg = "#666666" },
  SignColumn = base_transparent,
  StatusColumn = { bg = "none" },
  StatusLine = { bg = "none" },
  CursorLine = { bg = "none" },

  Comment = { fg = "#777777", italic = true },
  Visual = { bg = "#555555" },

  CmpDocumentation = { bg = "none" },
  CmpDocumentationBorder = { bg = "none" },

  NeoTreeEndOfBuffer = base_transparent,
  NeoTreeStatusLine = { bg = "none", fg = "#aba8a8" },
  NeoTreeTabInactive = { bg = "none", fg = "#aba8a8" },
  NeoTreeTabSeparatorInactive = { bg = "none", fg = "#202020" },
  NeoTreeSignColumn = { bg = "none", fg = "#aba8a8" },
  NeoTreePopup = { bg = "none", fg = "#aba8a8" },
  NeoTreePopupBorder = base_transparent,
  NeoTreeNormal = { bg = "none", fg = "#aba8a8" },
  NeoTreeNormalNC = { bg = "none", fg = "#aba8a8" },
  NeoTreeWinSeparator = { fg = "#404040" },

  TelescopeNormal = base_transparent,
  TelescopePreviewNormal = base_transparent,
  TelescopeResultsNormal = base_transparent,
  TelescopePromptNormal = base_transparent,
  TelescopePreviewBorder = { fg = "#404040", bg = "none" },
  TelescopeResultsBorder = { fg = "#404040", bg = "none" },
  TelescopePromptBorder = { fg = "#404040", bg = "none" },

  DiagnosticSignError = { fg = "#b96a65", bg = "none" },
  DiagnosticSignWarn = { fg = "#a37967", bg = "none" },
  DiagnosticSignInfo = { fg = "#708894", bg = "none" },
  DiagnosticSignHint = { fg = "#8d7e8e", bg = "none" },
  DiagnosticSignOk = { fg = "#7a8a6c", bg = "none" },
  DiagnosticUnnecessary = { fg = "#777777", italic = true },

  GitSignsAdd = { fg = "#4f6736", bg = "none" },
  GitSignsChange = { fg = "#c4b28a", bg = "none" },
  GitSignsDelete = { fg = "#a84843", bg = "none" },

  snacksDashboardDir = { fg = "#777777", italic = true },
  SnacksIndent = { bg = "none", fg = "#454545" },

  NotifyBackground = base_transparent,

  RenderMarkdownCode = { bg = "#232323" },
}

return {
  {
    "ramojus/mellifluous.nvim",
    lazy = true,
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
      -- vim.cmd.colorscheme "mellifluous"
    end,
  },
}
