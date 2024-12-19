local base_transparent = { bg = "none" }
local transparent = {
  Normal = base_transparent,
  TermCursor = { bg = "#f0f0f0", fg = "#000000" },
  NormalNC = base_transparent,
  NormalFloat = { bg = "#15151d" },
  FloatBorder = { fg = "#15151d", bg = "#15151d" },
  FloatTitle = { fg = "#99a8c6", bold = true, italic = true },
  Pmenu = { bg = "#15151d", fg = "#848484" },
  PmenuThumb = { bg = "#848484" },
  PmenuSbar = { bg = "#15151d" },

  WinBar = base_transparent,
  WinBarNC = base_transparent,
  WinSeparator = { fg = "#404040" },

  TabLineFill = base_transparent,
  LineNr = { fg = "#454545" },
  LineNrAbove = { fg = "#454545" },
  LineNrBelow = { fg = "#454545" },
  CursorLineNr = { fg = "#D8D6EB", bold = true },
  CursorLineFold = base_transparent,
  CursorLineSign = base_transparent,
  FoldColumn = { bg = "none", fg = "#666666" },
  SignColumn = base_transparent,
  StatusColumn = base_transparent,
  StatusLine = base_transparent,
  CursorLine = base_transparent,

  Comment = { fg = "#777777", italic = true },
  ["@comment.documentation"] = { fg = "#777777", italic = true },
  ["@parameter"] = { fg = "#dadada", bold = true },
  ["@markup.quote"] = { fg = "#dadada" },
  Keyword = { fg = "#99a8c6", italic = true },
  Constant = { fg = "#b99bb5", italic = true },
  Repeat = { fg = "#be7c7d", italic = true, bold = true },
  Conditional = { fg = "#be7c7d", italic = true, bold = true },
  Function = { fg = "#a8a1be", bold = true },
  String = { fg = "#c8bda6" },
  Special = { fg = "#99a8c6" },
  Visual = { bg = "#30303d" },
  IncSearch = { bg = "#be7c7d", fg = "#1a1a1a" },
  Label = { fg = "#be7c7d" },
  SpellRare = { fg = "#D8D6EB" },
  SpellLocal = { fg = "#D8D6EB" },
  SpellCap = { fg = "#D8D6EB" },
  Title = { fg = "#D8D6EB" },
  Question = { fg = "#D8D6EB" },
  MoreMsg = { fg = "#b99bb5" },
  SpecialKey = { fg = "#a8a1be" },

  CmpDocumentation = { bg = "#15151d" },
  CmpDocumentationBorder = { bg = "#15151d" },

  DiagnosticSignError = { fg = "#be7c7d" },
  DiagnosticSignWarn = { fg = "#c8bda6" },
  DiagnosticSignInfo = { fg = "#938ca8" },
  DiagnosticSignHint = { fg = "#a3869f" },
  DiagnosticUnnecessary = { fg = "#777777", italic = true },

  GitSignsAdd = { fg = "#94cbba" },
  GitSignsChange = { fg = "#EFD0A3" },
  GitSignsDelete = { fg = "#E68F8F" },

  HeirlineNormal = { fg = "#A8A1BE", bg = "#A8A1BE" },
  HeirlineVisual = { fg = "#EFD0A3", bg = "#EFD0A3" },
  HeirlineInsert = { fg = "#99a8c6", bg = "#99a8c6" },
  HeirlineCommand = { fg = "#b99bb5", bg = "#b99bb5" },
  HeirlineTerminal = { fg = "#99a8c6", bg = "#99a8c6" },
  HeirlineReplace = { fg = "#D8D6EB", bg = "#D8D6EB" },
  HeirlineInactive = { fg = "#777777", bg = "#777777" },
  StatusNormal = { fg = "#A8A1BE", bg = "#A8A1BE" },
  StatusVisual = { fg = "#EFD0A3", bg = "#EFD0A3" },
  StatusInsert = { fg = "#99a8c6", bg = "#99a8c6" },
  StatusCommand = { fg = "#b99bb5", bg = "#b99bb5" },
  StatusTerminal = { fg = "#99a8c6", bg = "#99a8c6" },
  StatusReplace = { fg = "#D8D6EB", bg = "#D8D6EB" },
  StatusInactive = { fg = "#777777", bg = "#777777" },

  NeoTreeEndOfBuffer = base_transparent,
  NeoTreeStatusLine = base_transparent,
  NeoTreeTabActive = { fg = "#D8D6EB", bold = true },
  NeoTreeTabInactive = { bg = "none", fg = "#aba8a8" },
  NeoTreeTabSeparatorInactive = { bg = "none", fg = "#202020" },
  NeoTreeSignColumn = base_transparent,
  NeoTreePopup = base_transparent,
  NeoTreePopupBorder = base_transparent,
  NeoTreeNormal = base_transparent,
  NeoTreeNormalNC = base_transparent,
  NeoTreeIndentMarker = { fg = "#272727" },
  NeoTreeWinSeparator = { fg = "#272727" },
  NeoTreeFileName = { fg = "#aba8a8" },
  NeoTreeFileNameOpened = { fg = "#D8D6EB" },
  NeoTreeGitModified = { fg = "#EFD0A3" },
  NeoTreeGitStaged = { fg = "#94cbba" },
  NeoTreeGitDeleted = { fg = "#E68F8F" },
  NeoTreeGitConflict = { fg = "#dcad66" },
  NeoTreeGitUntracked = { fg = "#b99bb5" },
  NeoTreeGitRenamed = { fg = "#99a8c6" },

  TelescopeNormal = { bg = "#15151d" },
  TelescopePreviewNormal = { bg = "#15151d" },
  TelescopeResultsNormal = { bg = "#15151d" },
  TelescopePromptNormal = { bg = "#15151d" },
  TelescopePreviewBorder = { fg = "#15151d", bg = "#15151d" },
  TelescopeResultsBorder = { fg = "#15151d", bg = "#15151d" },
  TelescopePromptBorder = { fg = "#15151d", bg = "#15151d" },
  TelescopePromptCounter = { fg = "#99a8c6" },
  TelescopeResultsTitle = { bg = "#be7c7d", fg = "#15151d", italic = true, bold = true },
  TelescopePreviewTitle = { bg = "#A8A1BE", fg = "#15151d", italic = true, bold = true },
  TelescopePromptTitle = { bg = "#99a8c6", fg = "#15151d", italic = true, bold = true },
  TelescopeMatching = { fg = "#c8bda6" },
  TelescopeSelection = { bg = "#20202d" },

  MasonHeader = { bg = "#99a8c6", fg = "#15151d", italic = true, bold = true },
  MasonHighlight = { fg = "#99a8c6", bold = true },
  MasonHiglightBlock = { bg = "#94cbba", fg = "#15151d" },

  LazyNormal = { bg = "#15151d" },
  LazyButton = { fg = "#aba8a8" },
  LazyButtonActive = { bg = "#99a8c6", fg = "#15151d", bold = true, italic = true },
  LazyReasonPlugin = { fg = "#aba1be", bold = true },
  LazyReasonSource = { fg = "#99a8c6", bold = true },
  LazyReasonCmd = { fg = "#c8bda6", bold = true },
  LazyReasonFt = { fg = "#b99bb5", bold = true },
  LazySpecial = { fg = "#99a8c6" },
  LazyCommit = { fg = "#c8bda6" },
  LazyCommitType = { fg = "#aba1be" },

  WhichKeyNormal = { link = "Normal" },

  snacksDashboardDir = { fg = "#afafaf", italic = true },
  SnacksDashboardFile = { fg = "#99a8c6" },
  SnacksDashboardIcon = { fg = "#99a8c6" },
  SnacksDashboardKey = { fg = "#A8A1BE" },
  SnacksDashboardDesc = { fg = "#cdcdcd" },
  SnacksDashboardHeader = { fg = "#cdcdcd" },
  SnacksDashboardFooter = { fg = "#cdcdcd" },
  SnacksDashboardTitle = { fg = "#cdcdcd" },
  SnacksDashboardSpecial = { fg = "#cdcdcd" },
  SnacksIndent = { bg = "none", fg = "#272727" },
  SnacksIndentScope = { bg = "none", fg = "#99a8c6" },

  UfoFoldedBg = { bg = "none" },
  UfoFoldedEllipsis = { bg = "#99a8c6", fg = "#15151d" },

  NotifyBackground = base_transparent,

  Todo = { fg = "#c8bda6", bg = "none" },
  RenderMarkdownCode = { bg = "#15151d" },
  RenderMarkdownH1Bg = { bg = "#342a2a", fg = "#db9697", bold = true },
  RenderMarkdownH2Bg = { bg = "#272831", fg = "#839cc6", bold = true },
  RenderMarkdownH3Bg = { bg = "#2b2731", fg = "#8C83C6", bold = true },
  RenderMarkdownH4Bg = { bg = "#313027", fg = "#C6BD83", bold = true },
  RenderMarkdownH5Bg = { bg = "none" },
  RenderMarkdownH6Bg = { bg = "none" },
}
return {
  {
    "ramojus/mellifluous.nvim",
    lazy = true,
    -- priority = 1000,
    opts = {
      colorset = "mellifluous",
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
      vim.g.terminal_color_0 = "#393552"
      vim.g.terminal_color_8 = "#6e6a86"

      vim.g.terminal_color_1 = "#be7c7d"
      vim.g.terminal_color_9 = "#cf7071"

      vim.g.terminal_color_2 = "#94cbba"
      vim.g.terminal_color_10 = "#7dc7b1"

      vim.g.terminal_color_3 = "#efd0a3"
      vim.g.terminal_color_11 = "#efdaa3"

      vim.g.terminal_color_4 = "#99a8c6"
      vim.g.terminal_color_12 = "#8da4d2"

      vim.g.terminal_color_5 = "#a8a1be"
      vim.g.terminal_color_13 = "#aca1cd"

      vim.g.terminal_color_6 = "#b99bb5"
      vim.g.terminal_color_14 = "#be96b9"

      vim.g.terminal_color_7 = "#d8d6eb"
      vim.g.terminal_color_15 = "#e0def4"
    end,
  },
}
