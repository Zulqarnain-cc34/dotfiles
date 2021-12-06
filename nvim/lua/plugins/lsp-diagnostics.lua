vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = true,
        underline = true,
        virtual_text = {spacing = 4, prefix = "◈ "}
    })


-- virtual_text = {spacing = 4, prefix = '雷'}
-- virtual_text = {spacing = 4, prefix = '◾'}
