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

packer.init {opt_default = false}

local use = packer.use
packer.reset()

return require('packer').startup(function()
    -- Packer can manage itself
    use {'wbthomason/packer.nvim'}

    use {"nvim-lua/popup.nvim"}

    use {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.nvim-web-devicons")
        end
    }

    use {
        'neovim/nvim-lspconfig',
        config = function()
            require("config")
        end
    }

    -- =================== Themes ===================

    use {'folke/tokyonight.nvim'}

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

    -- use {'hrsh7th/nvim-compe', event = 'InsertEnter *', config = [[require('plugins.compe')]]}

    use {'hrsh7th/nvim-compe', config = [[require('plugins.compe')]]}

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
         config = function()
             require'nvim-tree'.setup {}
         end
        --config = function()
            --require('plugins.nvimtree')
        --end
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
        config = function()
            require("plugins.lspkind")
        end
    }

    -- 'hrsh7th/vim-vsnip'
    use {'glepnir/lspsaga.nvim', event = 'BufRead'}

    -- use {'SirVer/ultisnips'}
    use {'hrsh7th/vim-vsnip'}

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

    use {'preservim/nerdcommenter', event = "BufReadPre"}

    use {'dstein64/vim-startuptime', event = 'VimEnter'}

    -- Colorizer and Indentation

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

    -- Colors and Tags

    use {
        'p00f/nvim-ts-rainbow',
        config = function()
            require("plugins.nvim-ts-rainbow")
        end,
        after = 'nvim-treesitter'
    }

    use {"windwp/nvim-ts-autotag", event = "InsertEnter", after = 'nvim-treesitter'}

    -- Lsp - Ui

    use {'folke/trouble.nvim', requires = 'nvim-web-devicons', cmd = "TroubleToggle"}

    use {'folke/lua-dev.nvim'}
    -- use {
    -- 'lewis6991/gitsigns.nvim',
    -- requires = {'nvim-lua/plenary.nvim'},
    -- opt = false,
    -- config = function()
    -- require('plugins.gitsigns')
    -- end
    -- }

end)

---- =================== Git =====================

-- paq 'tpope/vim-fugitive'
-- paq 'rhysd/git-messenger.vim'
-- paq 'Xuyuanp/nerdtree-git-plugin'
-- paq 'airblade/vim-gitgutter'

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

-- paq 'cstrap/python-snippets'
-- paq 'ylcnfrht/vscode-python-snippet-pack'

--------------------------------------------------------------------------
----                            Miscellenious                           --
--------------------------------------------------------------------------

-- paq 'folke/todo-comments.nvim'
-- paq 'tveskag/nvim-blame-line'
-- paq 'mzlogin/vim-markdown-toc'
-- paq 'tpope/vim-surround'
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

