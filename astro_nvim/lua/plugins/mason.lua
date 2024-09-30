--if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
    {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = {
          lsp = { auto_attach = true }, -- Enable auto-attach for LSP
        },
        config = function(_, opts)
          require("nvim-navbuddy").setup(opts) -- Use opts passed from `opts` table
          vim.api.nvim_set_keymap('n', '<leader>nn', '<cmd>Navbuddy<cr>', { noremap = true, silent = true })
        end
      }
    },
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      opts.ensure_installed = {
        "lua_ls",
        "pylsp"
        -- add more arguments for adding more language servers
      }

      -- Setup on_attach function for navbuddy
      opts.on_attach = function(client, bufnr)
        require("nvim-navbuddy").attach(client, bufnr)
      end
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "stylua",
        -- add more arguments for adding more null-ls sources
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "python",
        "clang"
        -- add more arguments for adding more debuggers
      },
    },
  },
}
