set nocompatible
set number relativenumber
set termguicolors

filetype plugin indent on
filetype plugin on

"Some Common Config Settings"
set wrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set encoding=UTF-8
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set smartindent   "
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  " case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  " shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000  " remember more commands and search history
set lazyredraw    " Don't redraw while executing macros (good performance config)
set magic         " For regular expressions turn magic on
set mat=2         " How many tenths of a second to blink when matching brackets
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title         " change the terminal's title
set visualbell    " don't beep
set noerrorbells  " don't beep
set nobackup      " Some servers have issues with backup files.
set nowritebackup
set cmdheight=2     " Bigger messages display. command line height
set updatetime=200  " Faster diagnostic messages (defaults 4000)
set shortmess+=   " Don't pass messages to |ins-completion-menu|
set mouse=a       " Enable mouse support
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set pastetoggle=<F2>

" Configures the autocompletion menu in the command line
set wildmenu
set wildmode=longest:full,full

" Allows the h and l key to move to next and previous line after
" hitting the end of next or previous line
set whichwrap=<,>,h,l

" Enable syntax highlighting
syntax enable

"set noswapfile   " to disable swap files.
"Disabling tab visualization in like HTML and XML files, "
autocmd filetype html,xml set listchars-=tab:>.

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
