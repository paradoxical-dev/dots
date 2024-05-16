local map = vim.keymap.set
map('n', '<leader>pp', [[<cmd>lua require('gitpad').toggle_gitpad()<CR>]])
map('n', '<leader>pb', [[<cmd>lua require('gitpad').toggle_gitpad_branch()<CR>]])
map('n', '<leader>pd', [[<cmd>lua require('gitpad').toggle_gitpad({ filename = 'daily-' .. os.date('%Y-%m-%d.md') })<CR>]])
map('n', '<leader>pn', [[<cmd>lua require('gitpad').toggle_gitpad({ filename = vim.fn.expand('%:p') .. '.md' })<CR>]])
