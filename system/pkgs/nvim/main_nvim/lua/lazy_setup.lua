-- VIM OPTIONS --

-- line #s
vim.opt.nu = true
vim.opt.relativenumber = true

-- indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- no swaps
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- UI
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = nil

-- global status
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.showcmdloc = "statusline"

-- folds
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- autoread edited files
vim.o.autoread = true

-- AUTOCMDS --
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 60,
    })
  end,
  desc = "Highlight on yank",
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Split help buffers to the right",
  pattern = "help",
  command = "wincmd L",
})

-- vim.api.nvim_create_autocmd("WinEnter", {
--   callback = function()
--     local bufnr = vim.api.nvim_get_current_buf()
--     local filetype = vim.bo[bufnr].filetype
--     print("WinEnter triggered! Filetype: " .. filetype) -- Debugging line
--
--     if filetype == "toggleterm" then
--       print("Entering insert mode in terminal") -- Debugging line
--       vim.cmd("startinsert!")
--     end
--   end,
--   desc = "Start insert mode when switching to terminal buffers",
-- })

-- LAZY SETUP --

require("lazy").setup({
  spec = { { import = "plugins" } },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
        "tutor",
      },
    },
  },
})
