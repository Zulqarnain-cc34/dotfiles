"Color Scheme For nvim "

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

colorscheme tokyonight

"Staring nvim deoplete autocomplete engine on startup
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#enable_ignore_case = 1

" Depolte auto completion delay
"call deoplete#custom#option('auto_complete_delay', 100)

" maximum deoplete window length
"call deoplete#custom#source('_', 'max_menu_width', 80)

"The buffer and around source for deoplete is of little use for auto-completion
"call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer']})

"Use ALE as completion sources for all code.
"call deoplete#custom#option('sources', {'_': ['ale']})

let g:ale_linters = {'python':["flake8","pylint"]} " ['flake8','bandit','pydocstyle','mypy','pylint']
let g:ale_fixers = {
\   "*":["remove_trailing_lines","trim_whitespace"],
\	"javascript": ["eslint","prettier"],
\	"python":["black","isort","autoimport"],
\ }  " ['black','isort'] isort for fixing import statements

" Use specified fixer on save
let g:ale_fix_on_save = 1

" Flake8 Configuration
let g:flake8_show_in_gutter = 1  " show flake in gutter

" Coc Nvim vim-Snippets Configuartion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
