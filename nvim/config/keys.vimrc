let mapleader = "m"

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
