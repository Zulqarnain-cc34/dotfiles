set nocompatible
set number relativenumber

let mapleader="m"

filetype plugin indent on
filetype plugin on

"Some Common Config Settings"
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
" allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting

set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                    "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                    "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set nobackup

set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set pastetoggle=<F2>

"Disabling tab visualization in like HTML and XML files, "
autocmd filetype html,xml set listchars-=tab:>.

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>
"Remappng : to ; since more convienient"
nnoremap ; :

"A Trick to  for when you forgot to sudo before editing a file that requires
"root privileges "
cmap w!! w !sudo tee % >/dev/null

"Forcing myself to stop usng arrow keys"
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>


call plug#begin('~/.config/nvim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'KeitaNakamura/neodark.vim'
Plug 'tiagovla/tokyodark.nvim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'frazrepo/vim-rainbow' 
Plug 'preservim/nerdcommenter' 
Plug 'norcalli/nvim-colorizer.lua'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

call plug#end()

set termguicolors

"Color Scheme"
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

colorscheme tokyonight 

