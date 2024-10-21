return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    opts = {
      code = {
        disable_background = {
          "lua",
          "javascript",
          "rust",
          "python",
          "c",
          "cpp",
          "json",
          "html",
          "css",
          "markdown",
          "bash",
          "dockerfile",
          "yaml",
          "toml",
          "latex",
          "make",
          "c_sharp",
          "java",
          "kotlin",
          "haskell",
          "hcl",
          "go",
          "jsonc",
          "sql",
        },
      },
    },
  },
}
