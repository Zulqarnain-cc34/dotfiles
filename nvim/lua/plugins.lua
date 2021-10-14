-- ===================================
-- ____  _             _
-- |  _ \| |_   _  __ _(_)_ __  ___
-- | |_) | | | | |/ _` | | '_ \/ __|
-- |  __/| | |_| | (_| | | | | \__ \
-- |_|   |_|\__,_|\__, |_|_| |_|___/
--               |___/
-- ===================================
local execute = vim.api.nvim_command
local fn = vim.fn

local packer_install_dir = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local plug_url_format = 'https://github.com/%s'

local packer_repo = string.format(plug_url_format, 'wbthomason/packer.nvim')
local install_cmd = string.format('10split |term git clone --depth=1 %s %s', packer_repo,
                                  packer_install_dir)

if fn.empty(fn.glob(packer_install_dir)) > 0 then
    vim.api.nvim_echo({{'Installing packer.nvim', 'Type'}}, true, {})
    execute(install_cmd)
    execute 'packadd packer.nvim'
end

local packer = require 'packer'

packer.startup {
    function()

    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({border = 'single'})
            end
        }
    }
}
-- packer.init {opt_default = false}

local use = packer.use
packer.reset()

return require('packer').startup(function()
    -- Packer can manage itself
    --
    use {'wbthomason/packer.nvim'}

    use {"nvim-lua/popup.nvim", 'kosayoda/nvim-lightbulb'}

    -- Icons for Nvimtree
    use {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.nvim-web-devicons")
        end
    }

    -- =================== Themes ===================

    use {'folke/tokyonight.nvim', disable = false}

    -- use  'ghifarit53/tokyonight-vim'
    -- use  "nekonako/xresources-nvim"
    -- use  "tanvirtin/monokai.nvim"
    -- use  "dracula/vim"
    -- use  'shaunsingh/moonlight.nvim'
    -- use  'tiagovla/tokyodark.nvim'

    -- Good Themes

    -- use 'ray-x/aurora'
    -- use 'mhartington/oceanic-next'
    -- use 'ChristianChiarulli/nvcode-color-schemes.vim'
    -- use 'sainnhe/sonokai'

    -- use 'ful1e5/onedark.nvim'

    use 'Th3Whit3Wolf/one-nvim'

    -- one dark theme
    -- use 'navarasu/onedark.nvim'
    -- use 'olimorris/onedark.nvim'
    -- use   'joshdick/onedark.vim'

    -- use {'MordechaiHadad/nvim-papadark', requires = {'rktjmp/lush.nvim'}}

    -- use {
    -- 'bkegley/gloombuddy',
    -- requires = 'tjdevries/colorbuddy.vim'
    ---- config = function()
    ---- require'colorbuddy'.colorscheme('gloombuddy')
    ---- end
    -- }

    -- ================== LSP, Autocomplete and Treesitter =====================

    -- html

    use {
        'mattn/emmet-vim',
        -- disable = true,
        -- event = "InsertEnter *",
        ft = {
            "html", "css", "javascriptreact", "scss", "javascript", "javascript.jsx", "typescript",
            "typescript.tsx", "typescriptreact"
        }
    }

    -- Snippets
    use {'hrsh7th/nvim-compe', event = 'InsertEnter *', config = [[require('plugins.compe')]]}

    use {
        'neovim/nvim-lspconfig',
        config = function()
            require("config")
        end
    }

    use {
        "tamago324/nlsp-settings.nvim",
        config = function()
            require'nlspsettings'.setup {config_home = vim.fn.stdpath('config') .. '/.nlspsettings'}
        end
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('plugins.nvimtree')
        end
    }

    use {
        'nvim-lua/lsp-status.nvim',
        config = function()
            require('lsp-status').register_progress()
        end
    }

    use {
        'ray-x/lsp_signature.nvim',
        config = function()
            require('plugins.lsp-signature-hint')
        end
    }

    use {
        'onsails/lspkind-nvim',
        event = "InsertEnter *",
        config = function()
            require("plugins.lspkind")
        end
    }

    use {'simrat39/symbols-outline.nvim'}

    use {'jose-elias-alvarez/nvim-lsp-ts-utils'}

    -- ultisnips
    use {'SirVer/ultisnips', event = "InsertEnter *", requires = {'honza/vim-snippets'}}

    -- use {'hrsh7th/vim-vsnip', event = "InsertEnter *"}

    -- Fuzzy finder

    use {
        "nvim-telescope/telescope.nvim",
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        config = function()
            require("plugins.telescope")
        end
    }

    -- use {
    -- 'windwp/nvim-autopairs',
    -- opt = true,
    -- after = 'nvim-compe',
    -- config = function()
    -- require('nvim-autopairs').setup()
    -- end
    -- }

    -- KeyBindings Viewer

    use {
        "folke/which-key.nvim",
        cmd = 'WhichKey',
        event = "BufWinEnter",
        config = function()
            require('plugins.whichkey')
        end
    }

    -- Status Bar and Bufferline
    use {
        'akinsho/bufferline.nvim',
        config = function()
            require('plugins.bufferline')
        end
    }

    use {
        'hoob3rt/lualine.nvim',
        config = function()
            require('plugins.lualine')
        end
    }

    -- Commenting
    --
    use {'preservim/nerdcommenter', event = "BufReadPre"}

    -- Colorizer and Indentation

    use {
        "norcalli/nvim-colorizer.lua",
        event = "BufRead",
        config = function()
            require("plugins.colorizer")
        end
    }

    -- Dashboard
    use {
        'glepnir/dashboard-nvim',
        event = "BufWinEnter",
        config = function()
            require("plugins.dashboard")
        end
    }

    -- Markdown Snippets

    use {'mzlogin/vim-markdown-toc', ft = "markdown"}

    -- Markdown Preview
    --
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        cmd = 'MarkdownPreview',
        ft = 'markdown'
    }

    -- Treesitter

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("plugins.nvim-treesitter")
        end
    }

    -- Colors,blanklines and Tags

    use {
        'p00f/nvim-ts-rainbow',
        after = 'nvim-treesitter',
        -- disable = true,
        config = function()
            require("plugins.nvim-ts-rainbow")
        end
    }

    use {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        disable = true,
        config = function()
            require("plugins.blankline")
        end
    }

    use {"windwp/nvim-ts-autotag", event = "InsertEnter", after = 'nvim-treesitter'}

    -- Lsp - Ui

    use {
        -- 'glepnir/lspsaga.nvim',
        'rinx/lspsaga.nvim',
        event = 'BufRead',
        config = function()
            require("plugins.lspsaga")
        end
    }

    use {
        'folke/trouble.nvim',
        requires = 'nvim-web-devicons',
        cmd = "TroubleToggle",
        config = function()
            require('plugins.trouble')
        end
    }

    -- Git
    --
    use {'tpope/vim-fugitive'}

    use {'airblade/vim-gitgutter'}

    use {'f-person/git-blame.nvim'}
    -- paq 'airblade/vim-gitgutter'

    use {
        'lewis6991/gitsigns.nvim',
        disable = true,
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('plugins.gitsigns')
        end
    }

    -- Documentation
    --
    use {'kkoomen/vim-doge', run = ":call doge#install()"}

    -- Miscellenious
    --
    use {
        'folke/todo-comments.nvim',
        event = "BufRead",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins.todocomments")
        end
    }

    use {'folke/lua-dev.nvim'}

    use {
        'dstein64/vim-startuptime',
        event = 'VimEnter',
        cmd = 'StartupTime',
        config = [[vim.g.startuptime_tries = 10]]
    }

end)

---- =================== File Traversing =================
---- paq 'preservim/nerdtree'
---- paq 'ojroques/nvim-lspfuzzy'
---- paq 'vim-utils/vim-man'
---- paq 'mg979/vim-visual-multi'

--------------------------------------------------------------------------
----                              Snippets                               --
--------------------------------------------------------------------------

-- paq 'hrsh7th/vim-vsnip'
-- paq 'sophacles/vim-processing'
-- paq 'rafamadriz/friendly-snippets'

-- paq 'Xuyuanp/nerdtree-git-plugin'
-- paq 'cstrap/python-snippets'
-- paq 'ylcnfrht/vscode-python-snippet-pack'

--------------------------------------------------------------------------
----                            Miscellenious                           --
--------------------------------------------------------------------------

-- paq 'tveskag/nvim-blame-line'
-- paq 'tpope/vim-surround'
-- paq 'cjrh/vim-conda'
-- paq 'tiagofumo/vim-nerdtree-syntax-highlight'
-- paq 'matbme/JABS.nvim'
-- paq 'mfussenegger/nvim-dap'
--

--------------------------------------------------------------------------

-- paq "derekwyatt/vim-fswitch"

--------------------------------------------------------------------------
----                                Lua                                 --
--------------------------------------------------------------------------

