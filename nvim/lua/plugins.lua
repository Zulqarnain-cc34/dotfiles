-- ===================================
-- _______  _             _
-- |  _ \| |_   _  __ _(_)_ __  ___
-- | |_) | | | | |/ _` | | '_ \/ __|
-- |  __/| | |_| | (_| | | | | \__ \
-- |_|   |_|\__,_|\__, |_|_| |_|___/
--               |___/
-- ===================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if vim.fn.isdirectory(lazypath) == 0 then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
    {
        'neovim/nvim-lspconfig',
        config = function()
            require("config")
        end,
        dependencies = {
            "b0o/schemastore.nvim",
        },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
    },
    {
        "folke/styler.nvim",
        config = function()
            require("styler").setup({
                themes = {
                    markdown = { colorscheme = "gruvbox" }
                },
            })
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = true,
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        lazy = false,
    },
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = { -- set to setup table
        },
    },
    {
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup()
        end
    },
    { "folke/neodev.nvim" },
    {
        "NeogitOrg/neogit",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",

            "ibhagwan/fzf-lua",
            "nvim-mini/mini.pick",
            "folke/snacks.nvim",
        },
        cmd = "Neogit",
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
        }
    },
    {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.nvim-web-devicons")
        end
    },
    {
        'kevinhwang91/nvim-hlslens',
        config = function()
            require("plugins.hlslens")
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "onsails/diaglist.nvim",
        config = function()
            require("plugins.diaglist")
        end
    },
    { "Tastyep/structlog.nvim" },

    -- ================== LSP, Autocomplete and Treesitter =====================
    {
        'onsails/lspkind-nvim',
        event = "BufRead",
        config = function()
            require("plugins.lspkind")
        end
    },
    {
        "navarasu/onedark.nvim",
        priority = 1000,
        config = function()
            require('onedark').setup {
                style = 'darker'
            }
            require('onedark').load()
        end
    },
    {
        "folke/which-key.nvim",
        cmd = 'WhichKey',
        event = "BufWinEnter",
        config = function()
            require('plugins.whichkey')
        end
    },
    {
        "amitds1997/remote-nvim.nvim",
        version = "*",                       -- Pin to GitHub releases
        dependencies = {
            "nvim-lua/plenary.nvim",         -- For standard functions
            "MunifTanjim/nui.nvim",          -- To build the plugin UI
            "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
        },
        config = true,
    },
    -- Status Bar and Bufferline
    {
        'akinsho/bufferline.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('plugins.bufferline')
        end
    },

    {
        'hoob3rt/lualine.nvim',
        config = function()
            require('plugins.lualine')
        end
    },
    -- Commenting
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        opts = {
            ensure_installed = {
                "lua", "python", "bash", "go", "html", "css", "javascript", "json", "c", "cpp", "markdown",
                "scss", "yaml", "typescript", "vim", "dart", "fish", "java", "dockerfile"
            },

            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = {
                enable = false,
            },
            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = 1000
            },
        },
    },

    -- Colors,blanklines and Tags
    {
        'HiPhish/rainbow-delimiters.nvim',
        after = 'nvim-treesitter',
        dependencies = { 'windwp/nvim-ts-autotag' },
    },

    { "windwp/nvim-ts-autotag", event = "InsertEnter", after = 'nvim-treesitter' },

    {
        'nvimdev/lspsaga.nvim',
        dependencies = { 'neovim/nvim-lspconfig' },
        config = function()
            require('lspsaga').setup({})
        end,
    },
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            keymap = {
                preset = 'default',
            },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = { documentation = { auto_show = false } },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        'folke/trouble.nvim',
        dependencies = 'nvim-web-devicons',
        cmd = "TroubleToggle",
        config = function()
            require('plugins.trouble')
        end
    },
    { "vimwiki/vimwiki" },

    {
        'folke/todo-comments.nvim',
        event = "BufRead",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins.todocomments")
        end
    },

    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime'
    },
})
