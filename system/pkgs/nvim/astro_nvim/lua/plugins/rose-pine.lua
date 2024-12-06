return {
  {
    "rose-pine/neovim",
    lazy = true,
    priority = 1000,
    opts = {
      variant = "moon",
      disable_background = true,
      enable = {
        terminal = true,
      },
      highlight_groups = {
        Normal = { bg = "none" },
        Cursor = { bg = "#000000", fg = "#e1e4dc" },
        NormalNC = { bg = "none" },
        NormalFloat = { link = "Normal" },
        FloatBorder = { link = "Normal" },
        TabLineFill = { link = "Normal" },
        WinBar = { link = "Normal" },
        WinBarNC = { link = "Normal" },
        WinSeparator = { fg = "#404040" },
        CursorLineFold = { link = "Normal" },
        CursorLineSign = { link = "Normal" },
        FoldColumn = { bg = "none", fg = "#666666" },
        SignColumn = { link = "Normal" },
        StatusLine = { bg = "none" },
        CursorLine = { bg = "none" },
        Comment = { fg = "#696969" },
        CmpDocumentation = { bg = "none" },
        CmpDocumentationBorder = { bg = "none" },
        snacksDashboardDir = { link = "Comment" },
        NotifyBackground = { link = "Normal" },
        RenderMarkdownCode = { bg = "#222222" },

        ["@property"] = { link = "@variable" },
      },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd "colorscheme rose-pine"
    end,
  },
}
