return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = true,
    keys = {
      { "<leader>o", "<cmd>Neotree toggle<CR>", desc = "Toggle NeoTree" },
    },
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      window = {
        width = 25,
      },
      default_component_configs = {
        modified = { symbol = "", highlight = "NeoTreeModified" },
      },
      filesystem = {
        follow_current_file = { enabled = true, leave_dirs_open = true },
      },
    },
  },
}
