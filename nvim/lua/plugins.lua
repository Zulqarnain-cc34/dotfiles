vim.cmd 'packadd paq-nvim'         -- Load package
local paq = require'paq-nvim'.paq  -- Import module and bind `paq` function

paq {'savq/paq-nvim', opt=true}     -- Let Paq manage itself

-- =================== Themes ===================

paq  'ghifarit53/tokyonight-vim'
--paq  'joshdick/onedark.vim'
--paq  'shaunsingh/moonlight.nvim'
--paq  'tiagovla/tokyodark.nvim'

-- =================== Git =====================

paq  'tpope/vim-fugitive'
paq  'rhysd/git-messenger.vim'
paq  'Xuyuanp/nerdtree-git-plugin'
paq  'airblade/vim-gitgutter'

-- =================== Others ==================

paq  'tpope/vim-surround'
paq  'preservim/nerdtree'
paq  'preservim/nerdcommenter'
paq  'junegunn/fzf'
paq  'junegunn/fzf.vim'
paq  'vim-utils/vim-man'
paq  'mg979/vim-visual-multi'
paq  'jiangmiao/auto-pairs'
paq  'glepnir/dashboard-nvim'
paq  'mzlogin/vim-markdown-toc'

-- Track the engine.
paq  'SirVer/ultisnips'
paq 'norcalli/nvim-colorizer'

-- Snippets are separated from the engine. Add this if you want them:
paq  'honza/vim-snippets'
paq  'dense-analysis/ale'
-- Syntax highlighting for python
paq  'numirias/semshi'
-- Use release branch (recommend)
paq  'neoclide/coc.nvim'
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
