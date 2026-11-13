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
    -- noice + nvim-notify removed: snacks.notifier handles notifications now.
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
    -- oil + mini.icons removed: snacks.explorer is the file explorer now.
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
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "NeogitOrg/neogit",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "folke/snacks.nvim", -- neogit uses snacks as its picker backend
        },
        cmd = "Neogit",
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
        }
    },
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("plugins.nvim-web-devicons")
        end
    },
    -- {
    --     'kevinhwang91/nvim-hlslens',
    --     config = function()
    --         require("plugins.hlslens")
    --     end
    -- },
    {
        "folke/tokyonight.nvim",
        lazy = true,  -- not the active scheme (onedark is); lazy.nvim loads it on :colorscheme if ever used
        priority = 1000,
        opts = {},
    },
    {
        "sphamba/smear-cursor.nvim",
        opts = {
            -- Smear cursor when switching buffers or windows.
            smear_between_buffers = true,

            -- Smear cursor when moving within line or to neighbor lines.
            -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
            smear_between_neighbor_lines = true,

            -- Draw the smear in buffer space instead of screen space when scrolling
            scroll_buffer_space = true,

            -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
            -- Smears and particles will look a lot less blocky.
            legacy_computing_symbols_support = false,

            -- Smear cursor in insert mode.
            -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
            smear_insert_mode = true,
            cursor_color = "#d3cdc3",
        },
    },
    {
        "onsails/diaglist.nvim",
        config = function()
            require("plugins.diaglist")
        end
    },
    { "Tastyep/structlog.nvim" },

    -- ================== LSP, Autocomplete and Treesitter =====================
    -- {
    --     'onsails/lspkind-nvim',
    --     event = "BufRead",
    --     config = function()
    --         require("plugins.lspkind")
    --     end
    -- },
    {
        "navarasu/onedark.nvim",
        priority = 1000,
        config = function()
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
        dependencies = { 'nvim-tree/nvim-web-devicons' }, -- was packer `requires` (ignored by lazy)
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
    {
        'nemanjamalesija/smart-paste.nvim',
        event = 'VeryLazy',
        config = true,
    },
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
    -- For `plugins.lua` users.
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        -- Completion for `blink.cmp`
        dependencies = { "saghen/blink.cmp" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main", -- the rewrite; the old master-style opts below are gone
        build = ":TSUpdate",
        lazy = false,
        config = function()
            require("nvim-treesitter").setup()

            -- main branch: parsers are installed via the install API, not
            -- `ensure_installed` in setup() (which is silently ignored now).
            -- The main branch COMPILES parsers with the `tree-sitter` CLI, so
            -- guard on it -- without the CLI, install() would error on every
            -- startup. Bundled parsers (lua/c/markdown/vim/vimdoc) still work.
            if vim.fn.executable("tree-sitter") == 1 then
                require("nvim-treesitter").install({
                    "lua", "python", "bash", "go", "html", "css", "javascript", "json", "c", "cpp",
                    "markdown", "markdown_inline", "scss", "yaml", "typescript", "tsx", "vim", "vimdoc",
                    "dart", "fish", "java", "dockerfile",
                })
            else
                vim.schedule(function()
                    vim.notify("nvim-treesitter: `tree-sitter` CLI not found -- run `sudo pacman -S tree-sitter-cli`, then :TSUpdate", vim.log.levels.WARN)
                end)
            end

            -- main branch: highlighting is started per buffer via FileType,
            -- not `highlight = { enable = true }`. Generic form covers every
            -- filetype that has a parser available. (indent left off, as before.)
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
                    if lang and vim.treesitter.language.add(lang) then
                        vim.treesitter.start(args.buf)
                    end
                end,
            })
        end,
    },

    -- Colors,blanklines and Tags
    {
        -- `after = 'nvim-treesitter'` was a packer key lazy ignores; ordering is
        -- handled via dependencies + an event trigger instead.
        'HiPhish/rainbow-delimiters.nvim',
        event = "BufReadPost",
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'windwp/nvim-ts-autotag' },
    },

    { "windwp/nvim-ts-autotag", event = "InsertEnter" },

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
    -- mini.nvim (unused, no setup) and dressing.nvim removed:
    -- snacks.input/snacks.picker provide the vim.ui.select/input UI now.
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        'folke/trouble.nvim',
        dependencies = 'nvim-web-devicons',
        cmd = "Trouble",
        config = function()
            require('plugins.trouble')
        end
    },

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
