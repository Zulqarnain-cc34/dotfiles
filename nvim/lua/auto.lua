vim.api.nvim_command([[
    autocmd FileType python nnoremap <F9> :!python %
    autocmd FileType cpp    nnoremap <F9> :!g++ %
    autocmd FileType javascript nnoremap <F9> :!node %
    autocmd FileType sh   nnoremap <F9> :!bash %
]])

-- Copies the test selected in visual mode and yanked with y to system clipboard
vim.api.nvim_command([[
    autocmd TextYankPost *
      \ if v:event.visual && v:operator == 'y' |
      \   let @+ = getreg(v:event.regname) |
      \ endif
]])

vim.api.nvim_command([[
  au BufEnter *.h  let b:fswitchdst = "c,cpp,cc,m"
  au BufEnter *.cc let b:fswitchdst = "h,hpp"
]])


-- vim.api.nvim_command([[
-- au BufWritePost ~/.config/nvim/*.{vim,lua} so $MYVIMRC
-- ]])
-- vim.api.nvim_command([[
-- augroup my-glyph-palette
-- autocmd! *
-- autocmd filetype startify,lua,typescript,python,javascript call glyph_palette#apply()
-- augroup end
-- ]])
