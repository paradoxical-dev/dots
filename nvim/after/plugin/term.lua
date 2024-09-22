require('toggleterm').setup({
    open_mapping = [[<c-a>]],
    autochdir = false,
    direction = 'float',
    float_opts = {
        border = 'curved',
        width = 100,
        height = 25,
    },
    winbar = {
        enabled = false
    },
})
