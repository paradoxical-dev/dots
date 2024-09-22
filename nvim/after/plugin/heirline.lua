-- global statusline
vim.o.laststatus = 3

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local colors = {
    bright_bg = utils.get_highlight("Folded").bg,
    bright_fg = utils.get_highlight("Folded").fg,
    red = utils.get_highlight("DiagnosticError").fg,
    dark_red = utils.get_highlight("DiffDelete").bg,
    green = utils.get_highlight("String").fg,
    blue = utils.get_highlight("Function").fg,
    gray = utils.get_highlight("Comment").fg,
    orange = utils.get_highlight("Constant").fg,
    purple = utils.get_highlight("Keyword").fg,
    pink = utils.get_highlight("Number").fg,
    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
    diag_error = utils.get_highlight("DiagnosticError").fg,
    diag_hint = utils.get_highlight("DiagnosticHint").fg,
    diag_info = utils.get_highlight("DiagnosticInfo").fg,
    git_del = utils.get_highlight("diffRemoved").fg,
    git_add = utils.get_highlight("diffAdded").fg,
    git_change = utils.get_highlight("diffChanged").fg,
}

require("heirline").load_colors(colors)

local ViMode = {
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
        self.mode_color = self.mode_colors[self.mode:sub(1, 1)]
        vim.g.mode_color = self.mode_color
    end,
    static = {
        mode_colors = {
            n = "blue" ,
            i = "purple",
            v = "pink",
            V =  "pink",
            ["\22"] =  "pink",
            c =  "orange",
            s =  "purple",
            S =  "purple",
            ["\19"] =  "purple",
            R =  "red",
            r =  "red",
            ["!"] =  "red",
            t =  "orange",
        }
    },

    provider = function(self)
        return "█"
    end,

    hl = function(self)
        -- vim.g.mode_color = self.mode_color
        return { fg = self.mode_colors[self.mode:sub(1, 1)], bold = true, }
    end,

    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function(self)
            vim.g.mode_color = self.mode_color
            vim.cmd("redrawstatus")
        end),
    },
}

local FileNameBlock = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. "  ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end
}

local FileName = {
    provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return "[No Name]" end

        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename
    end,
    hl = { fg = "#c9c7cd", bold = true },
}

local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = "[+]",
        hl = { fg = "#c9c7cd" },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "  ",
        hl = { fg = "orange" },
    },
}

local FileNameModifer = {
    hl = function()
        if vim.bo.modified then
            return { fg = "#c9c7cd", bold = true, force=true }
        end
    end,
}

FileNameBlock = utils.insert(FileNameBlock,
    FileIcon,
    utils.insert(FileNameModifer, FileName),
    FileFlags,
    { provider = '%<'}
)

local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
        self.hl = {fg = vim.g.mode_color}
    end,

    hl = { fg = vim.g.mode_color },

    {
        provider = function(self)
            return " " .. self.status_dict.head
        end,
        hl = { bold = true }
    },
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = "("
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and (" " .. count)
        end,
        hl = { fg = "git_add" },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and (" " .. count)
        end,
        hl = { fg = "git_del" },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and (" " .. count)
        end,
        hl = { fg = "git_change" },
    },
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = ")",
    },

}

local ScrollBar ={
    static = {
        sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
    },
    provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
        return string.rep(self.sbar[i], 2)
    end,
    update = {
        "CursorMoved",
    },
    hl = { fg = "grey", bg = "#161617" },
}

local Ruler = {
    provider = "%l:%c %P ",
    hl = { fg = "#c9c7cd" },
}

local Diagnostics = {

    condition = conditions.has_diagnostics,

    static = {
        error_icon = "   ",
        warn_icon = "   ",
        info_icon = " 󰌵  ",
        hint_icon = "   ",
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
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
        end,
        hl = { fg = "diag_error" },
    },
    {
        provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
        end,
        hl = { fg = "diag_warn" },
    },
    {
        provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. " ")
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

local LSPActive = {
    condition = conditions.lsp_attached,
    update = {
        "LspAttach",
        "LspDetach",
    },

    provider = function()
        local names = {}
        for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
        end
        return " [" .. table.concat(names, " ") .. "]"
    end,

    hl = { fg = "#c9c7cd", bold = true },
}

local Navic = {
    condition = function() return require("nvim-navic").is_available() end,
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
        end
    },
    init = function(self)
        local data = require("nvim-navic").get_data() or {}
        local children = {}
        for i, d in ipairs(data) do
            local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
            local child = {
                {
                    provider = d.icon,
                    hl = self.type_hl[d.type],
                },
                {
                    provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ''),

                    on_click = {
                        minwid = pos,
                        callback = function(_, minwid)
                            local line, col, winnr = self.dec(minwid)
                            vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), {line, col})
                        end,
                        name = "heirline_navic",
                    },
                },
            }
            if #data > 1 and i < #data then
                table.insert(child, {
                    provider = " > ",
                    hl = { fg = 'bright_fg' },
                })
            end
            table.insert(children, child)
        end
        self.child = self:new(children, 1)
    end,
    provider = function(self)
        return self.child:eval()
    end,
    hl = { fg = "gray" },
    update = 'CursorMoved'
}

local hidden_filetypes = {
    "neo-tree",
    "Outline",
    "packer",
    "help",
    "dashboard",
    "TelescopePrompt",
    "harpoon",
}

local Statusline = {
    condition = function (self)
        self.mode = vim.fn.mode()
        local mode = self.mode:sub(1, 1)
        if mode == "c" then
            return false
        end

        local filetype = vim.bo.filetype
        for _, ft in ipairs(hidden_filetypes) do
            if filetype == ft then
                return false
            end
        end

        return true
    end,

    {ViMode, {provider = "    "}, Git, {condition = conditions.is_git_repo, provider = "    "}, LSPActive, {provider = "    "}, Diagnostics,},

    {provider = '%= '},

    {Ruler, ScrollBar, {provider = "    "}, FileNameBlock, {provider = "    "}, ViMode},
}

local Winbar = {Navic}

local Tabline = {}

local Statuscolumn = {}

require('heirline').setup({
    statusline = Statusline,
    winbar = Winbar,
    tabline = nil,
    statuscolumn = nil,
    opts = {}
})
