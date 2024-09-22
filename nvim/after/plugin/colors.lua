function ColorMyPencils(color)
    color = color or "oldworld"

    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    local function set_highlight(group, color, style, bg_color)
        local command = string.format("highlight %s guifg=%s", group, color)
        if style then
            command = command .. " gui=" .. style
        end
        if bg_color then
            command = command .. " guibg=" .. bg_color
        end
        vim.cmd(command)
    end

    set_highlight("ColorColumn", "none", "none", "none")
    --
    set_highlight("StatusLine", "#ffffff", "none", "none")
    set_highlight("StatusLineNC", "#ffffff", "none", "none")
    set_highlight("WinBarNC", "#ffffff", "none", "none")
    set_highlight("WinBar", "#ffffff", "none", "none")
    -- set_highlight("CursorLine", "none", "none", "#4B4B4B")
    set_highlight("LineNr", "#3e3e49", "none", "none")
    set_highlight("SignColumn", "#262626", "none", "none")
    set_highlight("NormalNC", "none", "none", "none")
    set_highlight("Normal", "none", "none", "none")
    --
    -- set_highlight("DiagnosticVirtualTextHint", "#bac2de", "italic")
    -- set_highlight("DiagnosticSignHint", "#bac2de", "italic")
    --
    -- set_highlight("DashboardHeader", "#ecf3f4")
    -- set_highlight("DashboardFooter", "#d0d0d0", "italic")
    set_highlight("DashboardDesc", "#ecf3f4", "italic")
    -- set_highlight("StartupFoldedSection", "#d0d0d0")
    --
    -- set_highlight("CmpItemMenu", "#D2A8FF", "none", "none")
    -- set_highlight("CmpDocumentationBorder", "#ffffff", "none", "none")
    -- set_highlight("CmpDocumentation", "#e6edf3", "none", "none")
    --
    -- set_highlight("Pmenu", "#e6edf3", "none", "none")
    -- set_highlight("PmenuSel", "#e6edf3", "none", "#484f58")
    -- set_highlight("PmenuThumb", "#e6edf3", "none", "none")
    set_highlight("FloatBorder", "#d0d0d0", "none", "none")

    set_highlight("@comment", "#50585f", "none", "none")
    -- set_highlight("@string", "#a5a5a5", "none", "none")
    -- set_highlight("String", "#a5a5a5", "none", "none")

    -- set_highlight("Keyword", "#aca1cf", "italic", "none")
    set_highlight("@keyword.function", "#aca1cf", "italic", "none")

    -- set_highlight("@keyword.conditional", "#AFBDF8", "none", "none")
    -- set_highlight("@keyword.exception", "#AFBDF8", "none", "none")
    -- set_highlight("@keyword.repeat", "#AFBDF8", "none", "none")

    -- set_highlight("@comment", "#6c7582", "none", "none")
    -- set_highlight("Special", "#5ce3bf", "italic")
    -- set_highlight("Constant", "#2bd591", "bold")
    -- set_highlight("Visual", "#DADDDB", "none", "#7E7E95")

    set_highlight("@variable.parameter", "#c9c7cd", "italic", "none")
    set_highlight("@parameter", "#c9c7cd", "italic", "none")
    set_highlight("@variable.builtin", "#aca1cf", "italic", "none")
    set_highlight("Constant", "#ea835", "italic")

    set_highlight("Function", "#92a2d5", "bold")
    set_highlight("Type", "#e6b99d", "underline")
    set_highlight("Operator", "#e6b99d", "italic")
    -- set_highlight("Special", "#6CF04C", "italic")
    -- set_highlight("Statement", "#071404", "italic")
    -- set_highlight("Visual", "#474B52", "none", "#CFD2D0")
    -- set_highlight("@comment", "#1C4811", "none", "none")
    -- set_highlight("@Operator", "#49A732", "none", "none")

    set_highlight('NoiceCmdlinePopupBorder', '#d0d0d0', 'none', 'none')
    set_highlight('NoiceCmdlineIcon', '#d0d0d0', 'none', 'none')

    -- set_highlight("ObsidianRefText", "#ff7eb6", "italic")
    -- set_highlight("ObsidianTag", "#3ddbd9", "bold")

end

ColorMyPencils()
