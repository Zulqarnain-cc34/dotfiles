--===================================
-- ____  _             _
--|  _ \| |_   _  __ _(_)_ __  ___
--| |_) | | | | |/ _` | | '_ \/ __|
--|  __/| | |_| | (_| | | | | \__ \
--|_|   |_|\__,_|\__, |_|_| |_|___/
--               |___/
--===================================

vim.cmd 'packadd paq-nvim'         -- Load package
local paq = require'paq-nvim'.paq  -- Import module and bind `paq` function

paq {'savq/paq-nvim', opt=true}     -- Let Paq manage itself

-- =================== Themes ===================

--paq  'ghifarit53/tokyonight-vim'
--paq  'joshdick/onedark.vim'
--paq  'shaunsingh/moonlight.nvim'
paq  'tiagovla/tokyodark.nvim'

-- ================== LSP =====================

paq  'neovim/nvim-lspconfig'
paq  'hrsh7th/nvim-compe'
paq  'glepnir/lspsaga.nvim'
paq  'nvim-treesitter/nvim-treesitter'

-- =================== Git =====================

paq  'tpope/vim-fugitive'
paq  'rhysd/git-messenger.vim'
paq  'Xuyuanp/nerdtree-git-plugin'
paq  'airblade/vim-gitgutter'

-- =================== Others =================

paq  'windwp/nvim-autopairs'
paq  'tpope/vim-surround'
paq  'preservim/nerdtree'
paq  'preservim/nerdcommenter'
paq  'junegunn/fzf'
paq  'junegunn/fzf.vim'
paq  'ojroques/nvim-lspfuzzy'
paq  'vim-utils/vim-man'
paq  'mg979/vim-visual-multi'
paq  'glepnir/dashboard-nvim'
paq  'mzlogin/vim-markdown-toc'

-- Track the engine.
paq  'SirVer/ultisnips'
paq 'norcalli/nvim-colorizer.lua'

-- Snippets are separated from the engine. Add this if you want them:
paq  'honza/vim-snippets'
--paq  'dense-analysis/ale'
-- Syntax highlighting for python
--paq  'numirias/semshi'

-- On-demand lazy load
paq  'liuchengxu/vim-which-key'
-- Icons for Nerd tree
paq  'iamcco/markdown-preview.nvim'
paq  'cjrh/vim-conda'
paq  'ryanoasis/vim-devicons'
paq  'junegunn/rainbow_parentheses.vim'
paq  'tiagofumo/vim-nerdtree-syntax-highlight'
paq  'lambdalisue/glyph-palette.vim'
paq  'francoiscabrol/ranger.vim'
paq  'vimwiki/vimwiki'
-- If you are using Vim-paq
paq  'preservim/tagbar'


--==================== Setup ==========================

--require('Plugins/custom-plugins')
