-- lua/plugins.lua (Converted to lazy.nvim)

-- ===================================
-- _______  _             _
-- |  _ \| |_   _  __ _(_)_ __  ___
-- | |_) | | | | |/ _` | | '_ \/ __|
-- |  __/| | |_| | (_| | | | | \__ \
-- |_|   |_|\__,_|\__, |_|_| |_|___/
--               |___/
-- ===================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- OLD LINE: if not vim.loop.fs_stat(lazypath) then
if vim.fn.isdirectory(lazypath) == 0 then -- Check if the directory does NOT exist
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
    -- Configuration for nvim-lspconfig
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
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
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
        -- Optional dependencies
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
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
    "folke/neodev.nvim",
    {
        "NeogitOrg/neogit",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed.
            "ibhagwan/fzf-lua",    -- optional
            "nvim-mini/mini.pick", -- optional
            "folke/snacks.nvim",   -- optional
        },
        cmd = "Neogit",
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
        }
    },
    -- Icons (Explicitly listed as it has configuration in lua/plugins/nvim-web-devicons.lua)
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

    -- opt = true in packer usually means the plugin is lazy-loaded by default
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
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('onedark').setup {
                style = 'darker'
            }
            require('onedark').load()
        end
    },
    {

        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                'L3MON4D3/LuaSnip',
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    See the README about individual language/framework/plugin snippets:
                    --    https://github.com/rafamadriz/friendly-snippets
                    {
                        'rafamadriz/friendly-snippets',
                        config = function()
                            require('luasnip.loaders.from_vscode').lazy_load()
                        end,
                    },
                },
            },
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
        },
        config = function()
            require('plugins.nvim-cmp')
        end,
    },
    {
        "folke/which-key.nvim",
        cmd = 'WhichKey',
        event = "BufWinEnter",
        config = function()
            require('plugins.whichkey')
        end
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
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
        event = 'BufRead'
    },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
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
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false, -- Keep this to load it eagerly
        -- We remove the custom config function and use 'main' to load the module
        -- This ensures the module is added to the runtime path before configuration begins.
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
            -- Consolidated rainbow settings (from the old nvim-ts-rainbow.lua):
            rainbow = {
                enable = true,
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = 1000 -- Use the highest value from your original configs
            },
        },
    },

    -- Colors,blanklines and Tags
    {
        'HiPhish/rainbow-delimiters.nvim',
        after = 'nvim-treesitter',
        dependencies = { 'windwp/nvim-ts-autotag' },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        enabled = false, -- `disable = true` from packer
        config = function()
            require("plugins.blankline")
        end
    },

    { "windwp/nvim-ts-autotag", event = "InsertEnter", after = 'nvim-treesitter' },

    -- Lsp - Ui
    {
        'nvimdev/lspsaga.nvim',
        -- Since `after = 'nvim-lspconfig'` exists, we implicitly rely on it loading first
        dependencies = { 'neovim/nvim-lspconfig' },
        config = function()
            require('lspsaga').setup({})
        end,
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
