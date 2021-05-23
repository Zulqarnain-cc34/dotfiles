local on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
        vim.api.nvim_command [[augroup END]]
    end
end


require"lspconfig".efm.setup {
    on_attach = on_attach,
    init_options = {documentFormatting = true},
    filetypes = {"lua", "python"},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {
                {
                    formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=100 --break-after-table-lb",
                    formatStdin = true
                }
            },
            python = {
                {
                    LintCommand = "flake8 --ignore=E581 --stdin-display-name ${INPUT} -",
                    lintStdin = true,
                    lintFormats = {"%f:%l:%c: %m"},
                    formatCommand = "yapf --quiet",
                    formatStdin = true
                }, {
                    formatCommand = 'isort --quiet -',
                    formatStdin = true
                }
            }
        }
    }
}

