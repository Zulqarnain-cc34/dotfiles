vim.api.nvim_command([[
    autocmd FileType python nnoremap <F9> :!python %
    autocmd FileType cpp    nnoremap <F9> :!g++ %
    autocmd FileType javascript nnoremap <F9> :!node %
    autocmd FileType sh   nnoremap <F9> :!bash %
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
