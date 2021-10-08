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

packer.init {opt_default = true}

local use = packer.use
packer.reset()

return require('packer').startup(function()
    -- Packer can manage itself
    use {'wbthomason/packer.nvim', opt = false}

    use {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", opt = false}

    use {
        'neovim/nvim-lspconfig',
        opt = false,
        config = function()
            require("config")
        end
    }

    -- =================== Themes ===================

    use {'folke/tokyonight.nvim', opt = false}

    -- use  'ghifarit53/tokyonight-vim'
    -- use  "nekonako/xresources-nvim"
    -- use  "tanvirtin/monokai.nvim"
    -- use  "dracula/vim"
    -- use   'joshdick/onedark.vim'
    -- use  'shaunsingh/moonlight.nvim'
    -- use  'tiagovla/tokyodark.nvim'
    -- use  'navarasu/onedark.nvim'
    -- use  "monsonjeremy/onedark.nvim"

    -- ================== LSP and Treesitter =====================

    use {'hrsh7th/nvim-compe', event = 'InsertEnter *', config = [[require('plugins.compe')]]}
    --
    -- use {
    -- 'onsails/lspkind-nvim',
    -- 'nvim-lua/lsp-status.nvim',
    -- 'ray-x/lsp_signature.nvim',
    -- 'glepnir/lspsaga.nvim',
    -- }

    use {
        "nvim-telescope/telescope.nvim",
        opt = false,
        config = function()
            require("plugins.telescope")
        end
    }

    use {
        'windwp/nvim-autopairs',
        after = 'nvim-compe',
        config = function()
            require('nvim-autopairs').setup()
        end
    }

    use {
        "folke/which-key.nvim",
        cmd = 'WhichKey',
        event = "BufWinEnter",
        config = function()
            require('plugins.whichkey')
        end
    }

    use {
        'akinsho/bufferline.nvim',
        opt = false,
        config = function()
            require('plugins.bufferline')
        end
    }

    use {
        'hoob3rt/lualine.nvim',
        opt = false,
        config = function()
            require('plugins.lualine')
        end
    }

    use {'preservim/nerdcommenter', event = "BufReadPre"}

    use {'dstein64/vim-startuptime', event = 'VimEnter'}

    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        cmd = 'MarkdownPreview',
        ft = 'markdown'
    }

    use {
        "windwp/nvim-ts-autotag",
        requires = {'nvim-treesitter/nvim-treesitter'},
        event = "InsertEnter"
    }

    use {
        "norcalli/nvim-colorizer.lua",
        event = "BufRead",
        config = function()
            require("plugins.colorizer")
        end
    }

    use {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        config = function()
            require("plugins.blankline")
        end
    }

    use {
        'glepnir/dashboard-nvim',
        event = "BufWinEnter",
        config = function()
            require("plugins.dashboard")
        end
    }

    use {'mzlogin/vim-markdown-toc', ft = "markdown"}

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        opt = false,
        -- disable = true,
        config = function()
            require("plugins.nvim-treesitter")
        end
    }

    use {'p00f/nvim-ts-rainbow', requires = {"nvim-treesitter/nvim-treesitter"}, opt = false}

    use {'folke/trouble.nvim', cmd = "TroubleToggle"}

    ---- Use dependency and run lua function after load
    -- use {
    -- 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    -- config = function() require('gitsigns').setup() end
    -- }
    ---- You can specify multiple plugins in a single call
    -- use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}
    ---- You can alias plugin names
    -- use {'dracula/vim', as = 'dracula'}
end)

---- =================== Git =====================

-- paq 'tpope/vim-fugitive'
-- paq 'rhysd/git-messenger.vim'
-- paq 'Xuyuanp/nerdtree-git-plugin'
-- paq 'airblade/vim-gitgutter'

---- =================== File Traversing =================

---- paq 'preservim/nerdtree'
-- paq 'kyazdani42/nvim-tree.lua'
---- paq 'junegunn/fzf'
---- paq 'junegunn/fzf.vim'
-- paq 'nvim-lua/popup.nvim'
-- paq 'nvim-lua/plenary.nvim'
-- paq 'nvim-telescope/telescope.nvim'
---- paq 'ojroques/nvim-lspfuzzy'
---- paq 'vim-utils/vim-man'
---- paq 'mg979/vim-visual-multi'

--------------------------------------------------------------------------
----                              Snippets                               --
--------------------------------------------------------------------------

---- paq 'SirVer/ultisnips'
-- paq 'hrsh7th/vim-vsnip'
-- paq 'sophacles/vim-processing'
-- paq 'rafamadriz/friendly-snippets'

---- paq 'cstrap/python-snippets'
---- paq 'ylcnfrht/vscode-python-snippet-pack'

--------------------------------------------------------------------------
----                            Miscellenious                           --
--------------------------------------------------------------------------

-- paq 'folke/todo-comments.nvim'
-- paq 'tveskag/nvim-blame-line'
-- paq 'mzlogin/vim-markdown-toc'
-- paq 'tpope/vim-surround'
-- paq 'kyazdani42/nvim-web-devicons'
-- paq 'cjrh/vim-conda'
-- paq 'tiagofumo/vim-nerdtree-syntax-highlight'
-- paq 'kkoomen/vim-doge'
---- paq 'JMcKiern/vim-shoot'
---- paq 'vimwiki/vimwiki'
---- paq 'matbme/JABS.nvim'
-- paq 'mfussenegger/nvim-dap'
-- paq 'mfussenegger/nvim-dap-python'

----                                C++
--------------------------------------------------------------------------

-- paq "derekwyatt/vim-fswitch"

--------------------------------------------------------------------------
----                                Lua                                 --
--------------------------------------------------------------------------
-- paq 'folke/lua-dev.nvim'

