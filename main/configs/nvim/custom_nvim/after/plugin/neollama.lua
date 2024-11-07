require('neollama').setup({
    params = {
        stream = true
    },
    layout = {
        hl = {
            default_border = {link = "Normal"}
        },
        popup = {
            hl = {
                user_header = {link = "Function"},
                model_header = {link = "IncSearch"},
            }
        }
    }
})

vim.api.nvim_set_keymap('n', '<leader>cc', '<cmd>lua require("neollama").initialize()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<leader>c', '<cmd>lua require("neollama").initialize()<CR>', {noremap = true, silent = true})
