return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    lazy = true,
    ft = { "markdown" },
    opts = {
      code = {
        width = "block",
        left_pad = 1,
        right_pad = 1,
      },
      bullet = {
        enabled = false,
        icons = { "", "", "", "" },
      },
    },
  },
}
