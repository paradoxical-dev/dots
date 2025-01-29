return {
  {
    {
      "GeorgesAlkhouri/nvim-aider",
      cmd = {
        "AiderTerminalToggle",
      },
      keys = {
        { "<leader>ct", "<cmd>AiderTerminalToggle<cr>",   desc = "Open Aider" },
        {
          "<leader>cs",
          "<cmd>AiderTerminalSend<cr>",
          desc = "Send to Aider",
          mode = { "n", "v" },
        },
        { "<leader>ci", "<cmd>AiderQuickSendCommand<cr>", desc = "Send Command To Aider" },
        { "<leader>cb", "<cmd>AiderQuickSendBuffer<cr>",  desc = "Send Buffer To Aider" },
        { "<leader>c+", "<cmd>AiderQuickAddFile<cr>",     desc = "Add File to Aider" },
        { "<leader>c-", "<cmd>AiderQuickDropFile<cr>",    desc = "Drop File from Aider" },
      },
      dependencies = {
        "folke/snacks.nvim",
        { "nvim-telescope/telescope.nvim", lazy = true },
      },
      config = function()
        -- APPLIES COLORS --
        local terminal_color = "#17171f"
        local colors = {
          user_input_color = "Title",
          tool_output_color = "Function",
          tool_error_color = "DiagnosticSignError",
          tool_warning_color = "DiagnosticSignWarn",
          assistant_output_color = "Title",
          completion_menu_color = "Title",
          completion_menu_bg_color = terminal_color,
          completion_menu_current_color = "Keyword",
          completion_menu_current_bg_color = terminal_color,
        }

        local function int_to_hex(color)
          if type(color) == "string" then
            return false
          end
          return string.format("#%06x", color)
        end

        for k, v in pairs(colors) do
          if v == terminal_color then
            goto continue
          end
          local color = vim.api.nvim_get_hl(0, { name = v })
          colors[k] = int_to_hex(color.fg) or color.fg
          ::continue::
        end

        -- AUTOCMD FOR AUTO FILE UPDATING --
        vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
          callback = function()
            vim.cmd("checktime")
          end,
        })

        require("nvim_aider").setup({
          args = {
            "--model",
            "ollama_chat/qwen2.5-coder:14b",
            "--weak-model",
            "ollama_chat/llama3.2:latest",
            "--code-theme",
            "solarized-dark",
            "--no-auto-commits",
            "--pretty",
            "--stream",
          },
          theme = colors,
          config = {
            keys = {
              term_normal = {
                "<esc>",
                function(self)
                  self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
                  if self.esc_timer:is_active() then
                    self.esc_timer:stop()
                    vim.cmd("stopinsert")
                  else
                    self.esc_timer:start(100, 0, function() end)
                    return "<esc>"
                  end
                end,
                mode = "t",
                expr = true,
                desc = "Double escape to normal mode",
              },
            },
          },
          win = {
            position = "right",
            wo = {
              winhighlight = "Normal:Normal",
            },
            w = {
              aider = true
            },
            width = 0.25,
          },
        })
      end,
    },
  },
}
