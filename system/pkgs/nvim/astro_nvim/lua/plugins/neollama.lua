return {
  {
    "paradoxical-dev/neollama",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("neollama").setup {
        params = {
          model = "llama3.1:latest",
          stream = true,
        },
        web_agent = {
          agent_models = {
            use_current = false,
            buffer_agent = { model = "qwen2.5:3b" },
            reviewing_agent = { model = "qwen2.5:3b", options = { temperature = 0.2, num_ctx = 4096, top_p = 0.1 } },
            integration_agent = { model = _G.NeollamaModel, options = { num_ctx = 4096 } },
          },
        },
        layout = {
          border = {
            default = "rounded",
          },
          input = {
            hl = { fg = "#C9C7CD", bold = true, italic = true },
          },
        },
      }

      vim.api.nvim_set_keymap(
        "n",
        "<leader>cc",
        '<cmd>lua require("neollama").initialize()<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "v",
        "<leader>c",
        '<cmd>lua require("neollama").initialize()<CR>',
        { noremap = true, silent = true }
      )
    end,
  },
}