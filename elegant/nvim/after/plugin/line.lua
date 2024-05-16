local custom_colors = require'lualine.themes.auto'

--normal
custom_colors.normal.c.bg = "NONE"
custom_colors.normal.c.fg = "#ABABAB"
custom_colors.normal.a.bg = "#7E97AB"
custom_colors.normal.a.fg = "#32414D"
custom_colors.normal.b.bg = "#212021"
custom_colors.normal.b.fg = "#ABABAB"
--command
custom_colors.command.a.bg = "#8F88AF"
custom_colors.command.a.fg = "#37324B"
--visual
custom_colors.visual.a.bg = "#A2B5C1"
custom_colors.visual.a.fg = "#3B4D59"
--replace
custom_colors.replace.a.bg = "#B46958"
custom_colors.replace.a.fg = "#5B3D36"
--insert
custom_colors.insert.a.bg = "#88AFA2"
custom_colors.insert.a.fg = "#334C44"

require('lualine').setup {
    options = {
        theme = custom_colors,
    },
}
