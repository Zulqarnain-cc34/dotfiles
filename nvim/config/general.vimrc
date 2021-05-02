set nocompatible
set number relativenumber
set termguicolors

filetype plugin indent on
filetype plugin on

"Some Common Config Settings" set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
set encoding=UTF-8
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
" Some servers have issues with backup files.
set nowritebackup
" Bigger messages display. command line height
set cmdheight=1
" Faster diagnostic messages (defaults 4000)
set updatetime=200

" Enable mouse support
set mouse=a

set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set pastetoggle=<F2>
"set noswapfile   " to disable swap files.
"Disabling tab visualization in like HTML and XML files, "
autocmd filetype html,xml set listchars-=tab:>.
