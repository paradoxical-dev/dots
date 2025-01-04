return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "bash",
      },
    },
  },
}
