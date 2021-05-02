let mapleader = "m"

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" FZF Plugins keymappings
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-s> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
"nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>h :History<CR>

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

"Mappings for WhichKey
nnoremap <silent> <leader> :WhichKey 'm'<CR>
" By default timeoutlen is 1000 ms
set timeoutlen=500

" Mappings for Semshi Sytax highlighter for python
nmap <silent> <leader>rr :Semshi rename<CR>
nmap <silent> <Tab> :Semshi goto name next<CR>
nmap <silent> <S-Tab> :Semshi goto name prev<CR>
nmap <silent> <leader>C :Semshi goto class prev<CR>
nmap <silent> <leader>F :Semshi goto function next<CR>
nmap <silent> <leader>p :Semshi goto function prev<CR>
nmap <silent> <leader>gu :Semshi goto unresolved first<CR>
nmap <silent> <leader>gp :Semshi goto parameterUnused first<CR>
nmap <silent> <leader>ee :Semshi error<CR>
nmap <silent> <leader>ge :Semshi goto error<CR>

" Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Nerd Tree Key bindings

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-p> :NERDTreeFind<CR>
