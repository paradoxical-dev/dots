local custom_colors = require'lualine.themes.auto'

custom_colors.command.a.bg = '#17E8C1'
custom_colors.normal.a.bg = '#78A9FF'
custom_colors.visual.z.fg = '#BE95FF'
custom_colors.visual.a.fg = '#151515'

require('lualine').setup {
    options = {
        theme = custom_colors,
    },
}


