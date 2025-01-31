return {
  {
    "rebelot/heirline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "lewis6991/gitsigns.nvim",
      "williamboman/mason-lspconfig.nvim",
    },

    opts = function(_, opts)
      local conditions = require("heirline.conditions")
      local utils = require("heirline.utils")

      local colors = {
        bright_bg = "#B5B5B8",
        bright_fg = "#D0D0D1",
        dim_fg = "#828282",

        normal = utils.get_highlight("HeirlineNormal").bg,
        visual = utils.get_highlight("HeirlineVisual").bg,
        replace = utils.get_highlight("HeirlineReplace").bg,
        insert = utils.get_highlight("HeirlineInsert").bg,
        command = utils.get_highlight("HeirlineCommand").bg,
        terminal = utils.get_highlight("HeirlineTerminal").bg,
        inactive = utils.get_highlight("HeirlineInactive").bg,

        red = utils.get_highlight("DiagnosticError").fg,
        dark_red = utils.get_highlight("DiffDelete").bg,
        green = utils.get_highlight("String").fg,
        blue = utils.get_highlight("Function").fg,
        gray = utils.get_highlight("NonText").fg,
        orange = utils.get_highlight("Constant").fg,
        purple = utils.get_highlight("Statement").fg,
        cyan = utils.get_highlight("Special").fg,

        diag_warn = utils.get_highlight("DiagnosticWarn").fg,
        diag_error = utils.get_highlight("DiagnosticError").fg,
        diag_hint = utils.get_highlight("DiagnosticHint").fg,
        diag_info = utils.get_highlight("DiagnosticInfo").fg,

        git_bg = utils.get_highlight("MarkviewPalette6").bg,
        git_fg = utils.get_highlight("MarkviewPalette6").fg,
        git_del = utils.get_highlight("GitSignsDelete").fg,
        git_add = utils.get_highlight("GitSignsAdd").fg,
        git_change = utils.get_highlight("GitSignsChange").fg,
      }
      require("heirline").load_colors(colors)

      -- MODE --
      local ViMode = {
        init = function(self)
          self.mode = vim.fn.mode(1)
        end,
        static = {
          mode_colors = {
            n = "normal",
            i = "insert",
            v = "visual",
            V = "visual",
            ["\22"] = "visual",
            c = "command",
            s = "inactive",
            S = "inactive",
            ["\19"] = "inactive",
            R = "replace",
            r = "replace",
            ["!"] = "terminal",
            t = "terminal",
          },
        },
        provider = " ",
        hl = function(self)
          local mode = self.mode:sub(1, 1) -- get only the first mode character
          return { fg = self.mode_colors[mode], bg = self.mode_colors[mode], bold = true }
        end,
        update = {
          "ModeChanged",
          pattern = "*:*",
          callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
          end),
        },
      }

      -- FILENAME --
      local FileNameBlock = {
        init = function(self)
          self.filename = vim.api.nvim_buf_get_name(0)
        end,
      }

      local FileIcon = {
        init = function(self)
          local filename = self.filename
          local extension = vim.fn.fnamemodify(filename, ":e")
          self.icon, self.icon_color =
              require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
        end,
        provider = function(self)
          return self.icon and (self.icon .. " ")
        end,
        hl = function(self)
          return { fg = self.icon_color }
        end,
      }

      local FileName = {
        provider = function(self)
          local filename = vim.fn.fnamemodify(self.filename, ":.")
          if filename == "" then
            return "[No Name]"
          end
          if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
          end
          return filename
        end,
        -- hl = { fg = "NONE" },
        hl = { fg = "bright_fg" },
      }

      local FileFlags = {
        {
          condition = function()
            return vim.bo.modified
          end,
          provider = " ",
          hl = { bold = true },
        },
        {
          condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
          end,
          provider = " ",
          hl = { fg = "orange" },
        },
      }

      FileNameBlock = utils.insert(
        FileNameBlock,
        FileIcon,
        FileName,
        FileFlags,
        { provider = "%<" } -- this means that the statusline is cut here when there's not enough space
      )

      -- GIT --
      local GitBranchLBorder = { provider = "", hl = { fg = "git_bg" }, condition = conditions.is_git_repo }
      local GitBranchRBorder = { provider = "", hl = { fg = "git_bg" }, condition = conditions.is_git_repo }
      local GitBranch = {
        condition = conditions.is_git_repo,

        init = function(self)
          self.status_dict = vim.b.gitsigns_status_dict
        end,
        hl = { fg = "git_fg", bg = "git_bg" },

        { -- git branch name
          provider = function(self)
            return "  " .. self.status_dict.head .. " "
          end,
          hl = { bold = true },
        },
      }

      local GitChange = {
        condition = conditions.is_git_repo,

        init = function(self)
          self.status_dict = vim.b.gitsigns_status_dict
          self.has_changes = self.status_dict.added ~= 0
              or self.status_dict.removed ~= 0
              or self.status_dict.changed ~= 0
        end,

        {
          provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and (" " .. count .. " ")
          end,
          hl = { fg = "git_add" },
        },
        {
          provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and (" " .. count .. " ")
          end,
          hl = { fg = "git_del" },
        },
        {
          provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ("󰏬 " .. count .. " ")
          end,
          hl = { fg = "git_change" },
        },
      }

      -- DIAGNOSTICS --
      local Diagnostics = {

        condition = conditions.has_diagnostics,

        static = {
          error_icon = " ",
          warn_icon = " ",
          info_icon = "󰌵 ",
          hint_icon = " ",
        },

        init = function(self)
          self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
          self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
          self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
          self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        end,

        update = { "DiagnosticChanged", "BufEnter" },

        {
          provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.error_icon .. self.errors .. "  ")
          end,
          hl = { fg = "diag_error" },
        },
        {
          provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. "  ")
          end,
          hl = { fg = "diag_warn" },
        },
        {
          provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. "  ")
          end,
          hl = { fg = "diag_info" },
        },
        {
          provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
          end,
          hl = { fg = "diag_hint" },
        },
      }

      -- LSP --
      local LSPActive = {
        condition = conditions.lsp_attached,
        update = { "LspAttach", "LspDetach" },

        provider = function()
          local names = {}
          for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
          end
          return " " .. table.concat(names, " ")
        end,
        hl = { bold = true },
      }

      -- CURSOR POS --
      local Ruler = {
        provider = "%l:%c %P",
        hl = { fg = "bright_fg" },
      }

      local ScrollBar = {
        static = {
          sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
        },
        provider = function(self)
          local curr_line = vim.api.nvim_win_get_cursor(0)[1]
          local lines = vim.api.nvim_buf_line_count(0)
          local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
          if self.sbar[i] then
            return string.rep(self.sbar[i], 2)
          else
            return ""
          end
        end,
        hl = { fg = "cyan", bg = "NONE" },
      }

      -- CMD INFO --
      local function is_search()
        local search_term = vim.fn.getreg("/")
        local current_word = tostring(vim.fn.expand("<cword>"))
        local is_active = false
        if search_term and search_term ~= "" and current_word ~= "" then
          local escaped_search_term = search_term:gsub("([^%w])", "%%%1")
          local escaped_word = current_word:gsub("([^%w])", "%%%1")
          if search_term:match(escaped_word) or current_word:match(escaped_search_term) then
            is_active = true
          end
        end
        return vim.v.hlsearch ~= 0 and is_active
      end
      local function is_macro_recording()
        return vim.fn.reg_recording() ~= ""
      end
      local CmdInfo = {
        { provider = "[ ", hl = { fg = "dim_fg" } },
        {
          condition = is_search,
          init = function(self)
            local ok, search = pcall(vim.fn.searchcount)
            if ok and search.total then
              self.search = search
            end
          end,
          provider = function(self)
            local search = self.search
            return string.format(" %d/%d", search.current, math.min(search.total, search.maxcount)) or ""
          end,
          hl = { fg = "dim_fg", bold = true },
        },

        { provider = "  ", condition = is_macro_recording and is_search },

        {
          condition = is_macro_recording,
          provider = function()
            return "@ " .. vim.fn.reg_recording()
          end,
          hl = { fg = "dim_fg", bold = true },
          update = {
            "RecordingEnter",
            "RecordingLeave",
          },
        },
        { provider = " ]", hl = { fg = "dim_fg" } },

        condition = vim.opt.cmdheight == 0 and (is_search() or is_macro_recording()),
      }

      local section_separator = { provider = "    " }
      local separator = { provider = "  " }
      local git_separator = { provider = "    ", condition = conditions.is_git_repo }
      local git_section_sep = { provider = "  ", condition = conditions.is_git_repo }

      local main_status = {
        -- left
        {
          ViMode,
          git_separator,
          GitBranchLBorder,
          GitBranch,
          GitBranchRBorder,
          git_section_sep,
          GitChange,
          section_separator,
          FileNameBlock,
          separator,
          Diagnostics,
        },

        -- fill
        { provider = "%= " },

        -- right
        {
          CmdInfo,
          section_separator,
          LSPActive,
          section_separator,
          Ruler,
          separator,
          ScrollBar,
          section_separator,
          ViMode,
        },
      }

      opts.statusline = main_status

      -- NAVIC --
      local Navic = {
        condition = function()
          return require("nvim-navic").is_available()
        end,
        static = {
          type_hl = {
            File = "Directory",
            Module = "@include",
            Namespace = "@namespace",
            Package = "@include",
            Class = "@structure",
            Method = "@method",
            Property = "@property",
            Field = "@field",
            Constructor = "@constructor",
            Enum = "@field",
            Interface = "@type",
            Function = "@function",
            Variable = "@variable",
            Constant = "@constant",
            String = "@string",
            Number = "@number",
            Boolean = "@boolean",
            Array = "@field",
            Object = "@type",
            Key = "@keyword",
            Null = "@comment",
            EnumMember = "@field",
            Struct = "@structure",
            Event = "@keyword",
            Operator = "@operator",
            TypeParameter = "@type",
          },
          enc = function(line, col, winnr)
            return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
          end,
          dec = function(c)
            local line = bit.rshift(c, 16)
            local col = bit.band(bit.rshift(c, 6), 1023)
            local winnr = bit.band(c, 63)
            return line, col, winnr
          end,
        },
        init = function(self)
          local data = require("nvim-navic").get_data() or {}
          local children = {}
          -- create a child for each level
          for i, d in ipairs(data) do
            -- encode line and column numbers into a single integer
            local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
            local child = {
              {
                provider = d.icon,
                hl = self.type_hl[d.type],
              },
              {
                provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),

                on_click = {
                  -- pass the encoded position through minwid
                  minwid = pos,
                  callback = function(_, minwid)
                    -- decode
                    local line, col, winnr = self.dec(minwid)
                    vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
                  end,
                  name = "heirline_navic",
                },
              },
            }
            -- add a separator only if needed
            if #data > 1 and i < #data then
              table.insert(child, {
                provider = " > ",
                hl = { fg = "bright_fg" },
              })
            end
            table.insert(children, child)
          end
          -- instantiate the new child, overwriting the previous one
          self.child = self:new(children, 1)
        end,
        -- evaluate the children containing navic components
        provider = function(self)
          return self.child:eval()
        end,
        hl = { fg = "gray" },
        update = "CursorMoved",
      }

      opts.winbar = { Navic }
      opts.opts = {
        disable_winbar_cb = function(args)
          return conditions.buffer_matches({
            buftype = { "nofile", "prompt", "help", "quickfix", "terminal" },
            filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
          })
        end,
        disable_statusline_cb = function(args)
          return conditions.buffer_matches({
            buftype = { "terminal" },
          })
        end,
      }
    end,
  },
}
