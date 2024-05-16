function ColorMyPencils(color)
    color = color or "no-clown-fiesta"
    require('no-clown-fiesta').setup({transparent = true})
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
    set_highlight("ColorColumn", "#151515", "none", "#none")

    set_highlight("StatusLine", "#373737", "none", "none")
    set_highlight("StatusLineNC", "#373737", "none", "none")
    set_highlight("CursorLine", "none", "none", "#4B4B4B")

    set_highlight("DiagnosticVirtualTextWarn", "#C5A971", "italic")
    set_highlight("DiagnosticWarn", "#C5A971", "none")
    set_highlight("DiagnosticVirtualTextHint", "#7D8590", "italic")
    set_highlight("DiagnosticVirtualTextError", "#b50000", "italic")
    set_highlight("DiagnosticError", "#b50000")

    set_highlight("DashboardHeader", "#d0d0d0")
    set_highlight("DashboardCenter", "#d0d0d0")
    set_highlight("DashboardFooter", "#d0d0d0")
    set_highlight("StartupFoldedSection", "#d0d0d0")

    set_highlight("TelescopeMatching", "#FF7B72", "none", "none")
    set_highlight("TelescopeSelection", "white", "none", "none")
    set_highlight("TelescopeSelectionCaret", "#78A9FF", "none", "none")

    set_highlight("CmpItemMenu", "#D2A8FF", "none", "none")
    set_highlight("CmpDocumentationBorder", "#ffffff", "none", "none")
    set_highlight("CmpDocumentation", "#e6edf3", "none", "none")

    set_highlight("Pmenu", "#e6edf3", "none", "none")
    set_highlight("PmenuSel", "#e6edf3", "none", "#484f58")
    set_highlight("PmenuThumb", "#e6edf3", "none", "none")
    set_highlight("FloatBorder", "#d0d0d0", "none", "none")

    --set_highlight("@repeat", "#7ee787", "italic", "none")
    set_highlight("Comment", "#6C7582", "italic")
    --set_highlight("@type", "#7ee787")
    --set_highlight("Conditional", "#FF7E75", "bold")

    --Custom highlight groups
    vim.cmd('highlight link @keyword.repeat.javascript @repeat')
    vim.cmd('highlight link @keyword.conditional.javascript @conditional')

end

ColorMyPencils()
