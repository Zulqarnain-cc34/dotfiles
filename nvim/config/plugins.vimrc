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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_linters = {'python':["flake8","pylint"],'bash':["bashale"]} " ['flake8','bandit','pydocstyle','mypy','pylint']
let g:ale_fixers = {
\   "*":["remove_trailing_lines","trim_whitespace"],
\	"javascript": ["eslint","prettier"],
\	"python":["black","isort","autoimport"],
\ }  " ['black','isort'] isort for fixing import statements

let g:ale_fix_on_save = 1
" Flake8 Configuration
let g:flake8_show_in_gutter = 1  " show flake in gutter
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="tabdo"
" Unbinding the expand snippet key
let g:UltiSnipsExpandTrigger='<Nop>'
" Binding Tab to jump to next snippet
let g:UltiSnipsJumpForwardTrigger = '<TAB>'
" Binding Shift Tab to jump to previous snippet
let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'
" Binding Tab to next snippet
let g:coc_snippet_next = '<TAB>'
" Binding Shift Tab to next snippet
let g:coc_snippet_prev = '<S-TAB>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Rainbow Parenthesis Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'],['{','}']]
" List of colors that you do not want. ANSI code or #RRGGBB
let g:rainbow#blacklist = [233, 234]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Dev Icons Colors                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:devicons_colors = {
			\'normal': ['', '', '', '', ''],
			\'emphasize': ['', '', '', '', '', '', '', '', '', '', ''],
			\'yellow': ['', '', ''],
			\'orange': ['', '', '', 'λ', '', ''],
			\'red': ['', '', '', '', '', '', '', '', ''],
			\'magenta': [''],
			\'violet': ['', '', '', ''],
			\'blue': ['', '', '', '', '', '', '', '', '', '', '', '', ''],
			\'cyan': ['', '', '', ''],
			\'green': ['', '', '', '']
		\}
