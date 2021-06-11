-- ===================================
-- ____  _             _
-- |  _ \| |_   _  __ _(_)_ __  ___
-- | |_) | | | | |/ _` | | '_ \/ __|
-- |  __/| | |_| | (_| | | | | \__ \
-- |_|   |_|\__,_|\__, |_|_| |_|___/
--               |___/
-- ===================================
vim.cmd 'packadd paq-nvim' -- Load package
local paq = require'paq-nvim'.paq -- Import module and bind `paq` function

paq {'savq/paq-nvim', opt = true} -- Let Paq manage itself
-- =================== Themes ===================

paq 'ghifarit53/tokyonight-vim'
-- paq  'joshdick/onedark.vim'
-- paq  'shaunsingh/moonlight.nvim'
-- paq 'tiagovla/tokyodark.nvim'
-- paq 'navarasu/onedark.nvim'
paq "monsonjeremy/onedark.nvim"

-- ================== LSP and Treesitter =====================

paq 'neovim/nvim-lspconfig'
paq 'hrsh7th/nvim-compe'
paq 'glepnir/lspsaga.nvim'
paq 'nvim-treesitter/nvim-treesitter'
paq 'onsails/lspkind-nvim'
paq 'nvim-lua/lsp-status.nvim'
paq 'ray-x/lsp_signature.nvim'
paq 'folke/trouble.nvim'

-- =================== Git =====================

paq 'tpope/vim-fugitive'
paq 'rhysd/git-messenger.vim'
paq 'Xuyuanp/nerdtree-git-plugin'
paq 'airblade/vim-gitgutter'

-- =================== File Traversing =================

paq 'preservim/nerdtree'
-- paq 'junegunn/fzf'
-- paq 'junegunn/fzf.vim'
paq 'nvim-lua/popup.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'nvim-telescope/telescope.nvim'
-- paq 'ojroques/nvim-lspfuzzy'
-- paq 'vim-utils/vim-man'
-- paq 'mg979/vim-visual-multi'

------------------------------------------------------------------------
--                              Snippets                               --
------------------------------------------------------------------------

paq 'honza/vim-snippets'
--paq 'SirVer/ultisnips'
-- paq 'SirVer/ultisnips'
paq 'hrsh7th/vim-vsnip'
paq 'sophacles/vim-processing'
paq 'rafamadriz/friendly-snippets'

-- paq 'cstrap/python-snippets'
-- paq 'ylcnfrht/vscode-python-snippet-pack'

------------------------------------------------------------------------
--                            Miscellenious                           --
------------------------------------------------------------------------

-- paq 'npxbr/glow.nvim'
paq 'p00f/nvim-ts-rainbow'
paq 'hoob3rt/lualine.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'folke/todo-comments.nvim'
paq 'glepnir/dashboard-nvim'
paq 'mzlogin/vim-markdown-toc'
paq 'preservim/nerdcommenter'
paq 'windwp/nvim-autopairs'
paq 'tpope/vim-surround'
paq 'akinsho/nvim-bufferline.lua'
paq 'kyazdani42/nvim-web-devicons'
paq 'norcalli/nvim-colorizer.lua'
paq 'liuchengxu/vim-which-key'
paq 'iamcco/markdown-preview.nvim'
paq 'cjrh/vim-conda'
paq 'tiagofumo/vim-nerdtree-syntax-highlight'
paq 'lambdalisue/glyph-palette.vim'
paq 'kkoomen/vim-doge'
-- paq 'vimwiki/vimwiki'
-- paq 'matbme/JABS.nvim'

paq 'mfussenegger/nvim-dap'
paq 'mfussenegger/nvim-dap-python'
------------------------------------------------------------------------
--                                Lua                                 --
------------------------------------------------------------------------
paq 'folke/lua-dev.nvim'

