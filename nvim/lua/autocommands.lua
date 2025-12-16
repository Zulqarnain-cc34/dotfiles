function goimports(timeout_ms)
    local context = { only = { "source.organizeImports" } }
    -- Updated to new vim.validate signature: vim.validate({ name = { value, type, optional } })
    vim.validate({ context = { context, 'table', true } })

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
        if action.edit then vim.lsp.util.apply_workspace_edit(action.edit) end
        if type(action.command) == "table" then vim.lsp.buf.execute_command(action.command) end
    else
        vim.lsp.buf.execute_command(action)
    end
end

vim.api.nvim_command([[
     autocmd FileType python nnoremap <F9> :!python %
     autocmd FileType cpp    nnoremap <F9> :!g++ %
     autocmd FileType javascript nnoremap <F9> :!node %
     autocmd FileType sh   nnoremap <F9> :!bash %
     autocmd FileType c   nnoremap <F9> :!gcc %
     autocmd FileType typescript   nnoremap <F9> :!ts-node %
     autocmd BufWinEnter *.py call :!VenomActivate %
]])

-- vim.api.nvim_command([[
-- augroup packer_user_config
-- autocmd!
-- autocmd BufWritePost plugins.lua source <afile> | PackerCompile
-- augroup end
-- ]])
-- Copies the test selected in visual mode and yanked with y to system clipboard
-- vim.api.nvim_command([[
--     autocmd TextYankPost *
--       \ if v:event.visual && v:operator == 'y' |
--       \   let @+ = getreg(v:event.regname) |
--       \ endif
-- ]])

vim.api.nvim_command([[
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

vim.api.nvim_command([[
     au BufEnter *.h  let b:fswitchdst = "c,cpp,cc,m"
     au BufEnter *.cc let b:fswitchdst = "h,hpp"
]])

vim.api.nvim_command([[
     autocmd BufWritePre *.go lua goimports(1000)
]])

vim.api.nvim_command([[     hi Comment guifg=#968d8c   ]])
-- vim.api.nvim_command([[
-- au BufWritePost ~/.config/nvim/*.{vim,lua} so $MYVIMRC
-- ]])
-- vim.api.nvim_command([[
-- augroup my-glyph-palette
-- autocmd! *
-- autocmd filetype startify,lua,typescript,python,javascript call glyph_palette#apply()
-- augroup end
-- ]])
