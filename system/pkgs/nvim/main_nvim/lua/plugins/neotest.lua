return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",

      -- adapters
      "nvim-neotest/neotest-python",
    },
    -- event = "BufReadPre",
    keys = {
      {
        "<leader>xx",
        function()
          require("neotest").run.run()
        end,
        desc = "Run nearest test",
      },
      {
        "<leader>xX",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run tests in current file",
      },
      {
        "<leader>xl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Re-run last test",
      },
      {
        "<leader>xL",
        function()
          require("neotest").run.run_last({ strategy = "dap" })
        end,
        desc = "Re-run last test in debug mode",
      },
      {
        "<leader>xd",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Run nearest test in debug mode",
      },
      {
        "<leader>xD",
        function()
          require("neotest").run.run(vim.fn.expand("%"), { strategy = "dap" })
        end,
        desc = "Run current file in debug mode",
      },
      {
        "<leadeer>xs",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop nearest test",
      },
      {
        "<leader>xa",
        function()
          require("neotest").run.attach()
        end,
        desc = "Attach to nearest test",
      },
      {
        "<leader>xw",
        function()
          require("neotest").watch.toggle(vim.fn.expand("%"))
        end,
        desc = "Toggle current file watch",
      },
      {
        "<leader>xW",
        function()
          require("neotest").watch.toggle(vim.fn.expand("%:h"))
        end,
        desc = "Toggle parent dir watch",
      },
      {
        "<leader>xs",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle summary",
      },
      {
        "<leader>xf",
        function()
          require("neotest").output.open({ enter = true, quiet = false, auto_close = true })
        end,
        desc = "Open output window",
      },
      {
        "<leader>xc",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle output panel",
      },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python"),
        },
      })
    end,
  },
}
