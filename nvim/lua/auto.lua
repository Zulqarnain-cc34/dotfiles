--vim.api.nvim_command([[
    --autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)
    --autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
    --autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
    --autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
--]])