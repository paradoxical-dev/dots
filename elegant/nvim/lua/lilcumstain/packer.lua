-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    --    use {
        --        'nyoom-engineering/oxocarbon.nvim',
        --        as = 'oxocarbon',
        --    }

        --       use {
            --           "startup-nvim/startup.nvim",
            --           requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
            --           config = function()
                --               require("startup").setup({
                    --                   theme = "evil", 
                    --                   colors = {
                        --                       folded_secion = "#d0d0d0",
                        --                   },
                        --               })
                        --           end
                        --       }
                        --
                        use {
                            'nvimdev/dashboard-nvim',
                            event = 'VimEnter',
                            requires = {'nvim-tree/nvim-web-devicons'}
                        }

                        --use ({ 'projekt0n/github-nvim-theme' })

                        --use 'Mofiqul/vscode.nvim'

                        --use { "catppuccin/nvim", as = "catppuccin" }

                        use {"aktersnurra/no-clown-fiesta.nvim", as = "no-clown-fiesta"}

                        use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

                        use('theprimeagen/harpoon')

                        use('mbbill/undotree')

                        use('tpope/vim-fugitive')

                        -- use {
                            --     "folke/neodev.nvim",
                            --     require("neodev").setup({
                                --         library = {
                                    --             plugins = { "nvim-dap-ui" },
                                    --             types = true
                                    --         },
                                    --     })
                                    -- }

                                    use {
                                        'VonHeikemen/lsp-zero.nvim',

                                        requires = {
                                            {'williamboman/mason.nvim'},
                                            {'williamboman/mason-lspconfig.nvim'},
                                            {'neovim/nvim-lspconfig'},

                                            {'hrsh7th/cmp-buffer'},
                                            {'hrsh7th/cmp-path'},
                                            {'saadparwaiz1/cmp_luasnip'},
                                            {'hrsh7th/nvim-cmp'},
                                            {'hrsh7th/cmp-nvim-lsp'},
                                            {'hrsh7th/cmp-nvim-lua'},

                                            {'L3MON4D3/LuaSnip'},
                                            {'rafamadriz/friendly-snippets'},
                                        }
                                    }

                                    use {
                                        "williamboman/mason.nvim",
                                        "mfussenegger/nvim-dap",
                                        "jay-babu/mason-nvim-dap.nvim",
                                        "williamboman/mason-lspconfig.nvim",
                                        "neovim/nvim-lspconfig",
                                    }

                                    use {
                                        'nvim-lualine/lualine.nvim',
                                        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
                                    }

                                    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }

                                    use {
                                        "yujinyuz/gitpad.nvim",
                                        config = function ()
                                            require('gitpad').setup({})
                                        end
                                    }


                                end)
