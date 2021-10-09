require'lspconfig'.jsonls.setup {
     --cmd = { '/home/precision/.npm-packages/bin/vscode-json-language-server','--stdio' },

    commands = {
        Format = {
            function()
                vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
            end
        }
    }
}

