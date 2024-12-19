return {
  {
    "rebelot/heirline.nvim",
    event = "BufEnter",
    opts = function(_, opts)
      local status = require "astroui.status"
      local foo = {
        provider = "",
        condition = status.condition.is_git_repo(vim.api.nvim_get_current_buf()),
        update = { "User", "BufEnter", callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end) },
        init = status.init.update_events { "BufEnter" },
      }

      local bar = status.utils.surround(
        { "", " ▐" },
        "#EFD0A3",
        foo,
        function() return status.condition.is_git_repo(vim.api.nvim_get_current_buf()) end,
        {
          "User",
          callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end),
        }
      )

      opts.statusline = {
        hl = { fg = "fg", bg = "bg" },
        status.component.mode { hl = status.hl.get_attributes "mode" },
        -- bar,
        status.component.git_branch {
          -- surround = { separator = { "██", "█ " }, color = "#2D2c22" },
          surround = { separator = { "█", "█ " }, color = "#2D2c22" },
          hl = { bg = "#EFD0A3", fg = "#EFD0A3" },
        },
        status.component.file_info(),
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.virtual_env(),
        status.component.treesitter(),
        status.component.nav { surround = { separator = "center" } },
        status.component.mode { surround = { separator = "right" } },
      }
    end,
  },
}
