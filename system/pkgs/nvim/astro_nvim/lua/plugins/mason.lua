--if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- lazy = true,
    -- event = { "BufReadPre", "BufNewFile" },
    -- event = "VeryLazy",
    opts = function(_, opts)
      opts.ensure_installed = {
        "lua_ls",
        "pylsp",
        -- add more arguments for adding more language servers
      }

      -- Setup on_attach function for navbuddy
      opts.on_attach = function(client, bufnr) require("nvim-navbuddy").attach(client, bufnr) end
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- lazy = true,
    -- event = { "BufWritePre" },
    -- event = "VeryLazy",
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
    -- lazy = true,
    -- event = "LspAttach",
    -- event = "VeryLazy",
    -- keys = {
    --
    -- },
    opts = {
      ensure_installed = {
        "python",
        "clang",
        "bash",
        "chrome",
        "js",
        "cppdbg",
      },
      handlers = {
        function(config) require("mason-nvim-dap").default_setup(config) end,

        bash = function(config)
          config.adapters = {
            type = "executeable",
            command = "sh",
          }
        end,
      },
    },
  },
}
