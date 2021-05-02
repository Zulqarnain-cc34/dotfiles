let mapleader = "m"

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>

" FZF Plugins keymappings 
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>h :History<CR>

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
