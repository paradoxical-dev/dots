return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = false },
      notifier = { enabled = false },
      words = { enabled = false },

      dashboard = {
        sections = {
          {
            section = "terminal",
            cmd = "chafa ~/Downloads/IMG_7857.jpeg --format symbols --symbols vhalf --size 50x34 --stretch; sleep 0.1",
            height = 34,
            padding = 1,
          },
          {
            pane = 2,
            { icon = "󰌌", title = "Keymaps" },
            { section = "keys", padding = { 2, 1 } },
            { icon = "", title = "Recent Files" },
            { section = "recent_files", padding = { 2, 1 } },
            { icon = "", title = "Projects" },
            { section = "projects", padding = { 5, 1 } },
            { section = "startup" },
          },
        },
      },
    },
  },
}
