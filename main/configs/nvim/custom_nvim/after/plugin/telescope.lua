require('telescope').setup{
    defaults = {
        file_ignore_patterns = {"node_modules", ".ttf"}
    },
    pickers = {
        find_files = {
            theme = "dropdown",
        },
    },
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>o', function ()
    builtin.find_files({ cwd = _G.current_ws })
end)

local daily_notes = "~/Documents/obsidian/main/daily notes/"
vim.keymap.set('n', '<leader>pd', function ()
    builtin.find_files({
        cwd = daily_notes,
        propmpt_title = daily_notes,
    })
end)

vim.keymap.set('n', '<leader>pp', function ()
    builtin.find_files({ cwd = _G.current_ws .. _G.obsidian_subdir })
end)

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
