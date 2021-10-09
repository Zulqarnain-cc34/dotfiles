"let mapleader = "m"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              fzf keyBindings                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" FZF Plugins keymappings
"nnoremap <silent> <Leader>b :Buffers<CR>
"nnoremap <silent> <C-s> :Files<CR>
"nnoremap <silent> <Leader>f :Rg<CR>
""nnoremap <silent> <Leader>/ :BLines<CR>
"nnoremap <silent> <Leader>' :Marks<CR>
"nnoremap <silent> <Leader>gg :Commits<CR>
"nnoremap <silent> <Leader>H :Helptags<CR>
"nnoremap <silent> <Leader>h :History<CR>


"nnoremap <C-s> <cmd>lua require('telescope.builtin').find_files()<cr>
"nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
"nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
"nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
"nnoremap <leader>fm <cmd>lua require('telescope.builtin').marks()<cr>
"nnoremap <leader>fl <cmd>lua require('telescope.builtin').oldfiles()<cr>
"nnoremap <leader>fa <cmd>lua require('telescope.builtin').man_pages()<cr>




" Errors in Red
"hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red
"" Warnings in Yellow
"hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow
"" Info and Hints in White
"hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White
"hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=White

"" Underline the offending code
"hi LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline
"hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline
"hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline
"hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Coc KeyBindings                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Mappings for CoCList
" List the snippets for the specific file
"nnoremap <silent> <Leader>ns :CocList snippets<CR>
"" Show all diagnostics.
"nnoremap <silent><nowait> <leader>na  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
"nnoremap <silent><nowait> <leader>ne  :<C-u>CocList extensions<cr>
"" Show commands.
"nnoremap <silent><nowait> <leader>nc  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"nnoremap <silent><nowait> <leader>no  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"nnoremap <silent><nowait> <leader>ny  :<C-u>CocList -I symbols<cr>
"" Do default action for next item
"nnoremap <silent><nowait> <leader>nj  :<C-u>CocNext<CR>
"" Do default action for previous it	em.
"nnoremap <silent><nowait> <leader>nk  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"nnoremap <silent><nowait> <leader>np  :<C-u>CocListResume<CR>
"
"
"nnoremap <silent><nowait> <leader>nl :CocOpenLog <CR>
"
"" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"
"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()
"
"" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"
"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  elseif (coc#rpc#ready())
"    call CocActionAsync('doHover')
"  else
"    execute '!' . &keywordprg . " " . expand('<cword>')
"  endif
"endfunction
"
"" <TAB> - trigger completion, pum navigate, snippet expand and jump like VSCode
"inoremap <silent><expr> <TAB>
"  \ pumvisible() ? "\<C-n>" :
"  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"  \ <SID>check_back_space() ? "\<TAB>" :
"  \ coc#refresh()
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"
"" <CR> - select the first completion item and confirm the completion when no item has been selected
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Semshi KeyBindings                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Mappings for Semshi Sytax highlighter for python
"nmap <silent> <leader>rr :Semshi rename<CR>
""nmap <silent> <Tab> :Semshi goto name next<CR>
""nmap <silent> <S-Tab> :Semshi goto name prev<CR>
"nmap <silent> <leader>C :Semshi goto class prev<CR>
"nmap <silent> <leader>F :Semshi goto function next<CR>
"nmap <silent> <leader>p :Semshi goto function prev<CR>
"nmap <silent> <leader>gu :Semshi goto unresolved first<CR>
"nmap <silent> <leader>gp :Semshi goto parameterUnused first<CR>
"nmap <silent> <leader>ee :Semshi error<CR>
"nmap <silent> <leader>ge :Semshi goto error<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Nerd Tree KeyBindings                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerd Tree Key bindings

"nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <leader>n :NERDTree<CR>
"nnoremap <C-t> :NERDTreeToggle<CR>
"nnoremap <C-p> :NERDTreeFind<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Fugitive KeyBindings                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fugitive git bindings
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   General Keybindings                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mapping to Move between Tabs"
"
noremap<C-j> :tabp<CR>
noremap<C-k> :tabn<CR>
noremap<C-h> :tabr<CR>
noremap<C-l> :tabl<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Miscellenious                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Remappng : to ; since more convienient"
nnoremap ; :

"A Trick to  for when you forgot to sudo before editing a file that requires
"root privileges "
cmap w!! w !sudo tee % >/dev/null

"Forcing myself to stop usng arrow keys and page up down keys"
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
map <PageUp> <nop>
map <PageDown> <nop>

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>


	

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Rainbow Parenthesis Settings                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Activation based on file type
"augroup rainbow_lisp
  "autocmd!
  "autocmd FileType lisp,clojure,scheme,javascript,python RainbowParentheses
"augroup END

"" Activate
"nnoremap <leader>ra :RainbowParentheses<CR>

"" Deactivate
"nnoremap <leader>rd :RainbowParentheses!<CR>

"" Toggle
"nnoremap <leader>rt :RainbowParentheses!!<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Glyph Palette                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Which Key Plugin                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Mappings for WhichKey
"nnoremap <silent> <leader> :WhichKey <CR>

" By default timeoutlen is 1000 ms
"set timeoutlen=500


" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Highlight Groups for AutoComplete menu                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=#FFD400 guibg=#1C1C1C gui=NONE
"hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87
"gui=NONE
"
":command! -nargs=* Tmuxnew :! tmux new-window -n "<args>" && tmux send-keys "<args>" 'Enter'
