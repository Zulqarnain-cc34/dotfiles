call plug#begin('~/.config/nvim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'KeitaNakamura/neodark.vim'
Plug 'rhysd/git-messenger.vim'

"Plug 'frazrepo/vim-rainbow'
Plug 'ghifarit53/tokyonight-vim'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-utils/vim-man'
"Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'glepnir/dashboard-nvim'
Plug 'mzlogin/vim-markdown-toc'
" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

Plug 'dense-analysis/ale'
" Syntax highlighting for python
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" On-demand lazy load
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
" Icons for Nerd tree
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'cjrh/vim-conda'

Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'vimwiki/vimwiki'
" If you are using Vim-Plug
Plug 'shaunsingh/moonlight.nvim'

" Deoplete AutoComplete Engine
"Plug 'zchee/deoplete-jedi'
"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif

call plug#end()
