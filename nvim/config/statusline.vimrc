
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Status Line                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

let g:currentmode={
       \ 'n'  : 'NORMAL',
       \ 'v'  : 'VISUAL',
       \ 'V'  : 'V·Line',
       \ "\<C-V>" : 'V·Block',
       \ 'i'  : 'INSERT',
       \ 'R'  : 'R',
       \ 'Rv' : 'V·Replace',
       \ 'c'  : 'Command',
       \}

set laststatus=2
set statusline+=%l
set statusline+=\ %{toupper(g:currentmode[mode()])}
set statusline+=%{StatuslineGit()}
set statusline+=%{&modified?'[+]':''}
