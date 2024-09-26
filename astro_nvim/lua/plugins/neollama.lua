return {
  {
    'jaredonnell/neollama',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim'
    },
    config = function ()
      require("neollama").setup({
        params = {
          model = 'llama3.1:latest',
          stream = true
        },
        layout = {
          size = {
            height = math.floor(vim.o.lines * 0.8)
          }
        }
      })

      vim.api.nvim_set_keymap('n', '<leader>cc', '<cmd>lua require("neollama").initialize()<CR>', {noremap = true, silent = true})
      vim.api.nvim_set_keymap('v', '<leader>c', '<cmd>lua require("neollama").initialize()<CR>', {noremap = true, silent = true})
    end
  }
}
