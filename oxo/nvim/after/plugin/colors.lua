function ColorMyPencils(color)
    color = color or "oxocarbon"
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

    set_highlight("String", "#F0E7FF")
    set_highlight("Error", "#E11E51", "italic", "151515")
    set_highlight("@function", "#FF7EB6", "bold")
    set_highlight("Type", "#65FFC6")
    set_highlight("@boolean", "#65FFC6")
    set_highlight("@repeat", "#65FFC6")
    set_highlight("@constant", "#F1B2F1")
    set_highlight("@method", "#65FFC6")
    set_highlight("@conditional", "#65FFC6")
    set_highlight("@keyword.function", "#65FFC6")
    set_highlight("@variable", "#D9E9FF", "italic")
    set_highlight("@parameter", "#A1E7FF")
    set_highlight("@include", "#24dba1")
    set_highlight("@property", "#BE95FF")
    set_highlight("@Number", "#ffffff")
    set_highlight("StatusLineNC", "#ffffff")
    set_highlight("ColorColumn", "#151515", "none", "#none")
    set_highlight("TelescopePromptTitle", "#151515", "italic", "none")
    set_highlight("TelescopePreviewTitle", "#ff7eb6", "italic", "none")
    set_highlight("TelescopeResultsTitle", "#78A9FF", "italic", "none")
    set_highlight("TelescopePromptNormal", "#f2f2f2", "none", "#131313")
    set_highlight("TelescopePromptBorder", "#131313", "none", "#131313")
    set_highlight("TelescopePromptPrefix", "#f2f2f2", "none", "#131313")
    set_highlight("TelescopeBorder", "#131313")
end

ColorMyPencils()
