call plug#begin('~/.config/nvim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'KeitaNakamura/neodark.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'ghifarit53/tokyonight-vim'
Plug 'preservim/nerdcommenter'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-utils/vim-man'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'

call plug#end()

