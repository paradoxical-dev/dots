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

    use {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function ()
            require('dashboard').setup(require('lilcumstain.dashboard-config'))
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    }

    -- use {'nyoom-engineering/oxocarbon.nvim'}

    -- use 'Mofiqul/vscode.nvim'

    -- use 'dzfrias/noir.nvim'

    -- use 'arcticicestudio/nord-vim'

    --use {"aktersnurra/no-clown-fiesta.nvim", as = "no-clown-fiesta"}

    -- use { "catppuccin/nvim", as = "catppuccin" }

    -- use {
    --     'olivercederborg/poimandres.nvim',
    --     config = function ()
    --         require('poimandres').setup{}
    --     end
    -- }

    -- use "owickstrom/vim-colors-paramount"

    -- use "rose-pine/neovim"

    -- use 'roobert/palette.nvim'

    use "dgox16/oldworld.nvim"

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    use('theprimeagen/harpoon')

    use('mbbill/undotree')

    use('tpope/vim-fugitive')

    use 'lewis6991/gitsigns.nvim'

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

    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }

    use ({
        "epwalsh/obsidian.nvim",
        tag = "*",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

    use {
        'MunifTanjim/nui.nvim'
    }

    use "rebelot/heirline.nvim"


    use {
        'wakatime/vim-wakatime'
    }

    use {
        'rmagatti/goto-preview',
        config = function()
            require('goto-preview').setup {}
        end
    }

    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end}

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim",
            {
                's1n7ax/nvim-window-picker',
                version = '2.*',
                config = function()
                    require 'window-picker'.setup({
                        filter_rules = {
                            include_current_win = false,
                            autoselect_one = true,
                            bo = {
                                filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                                buftype = { 'terminal', "quickfix" },
                            },
                        },
                    })
                end,
            },
        },
    }

    -- use 'rcarriga/nvim-notify'

    use 'folke/noice.nvim'

    use {
        "karb94/neoscroll.nvim",
        config = function ()
            require('neoscroll').setup({})
        end
    }

    use ({"ziontee113/color-picker.nvim",
        config = function()
            require("color-picker")
        end,
    })

    use 'simrat39/symbols-outline.nvim'

    use {
        'Exafunction/codeium.vim',
        config = function ()
            vim.g.codeium_filetypes = {dashboard = false}
            -- Change '<C-g>' here to any keycode you like.
            vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
            vim.keymap.set('i', '<C-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
            vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
            vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
        end
    }

    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig"
    }

    use {
        "SmiteshP/nvim-navbuddy",
        requires = {
            "neovim/nvim-lspconfig",
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim",
            "numToStr/Comment.nvim",        -- Optional
            "nvim-telescope/telescope.nvim" -- Optional
        }
    }

    use {
        'jaredonnell/neollama',
        requires = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim'
        },
    }
end)
