vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	signs = true,
        underline = true,
        -- This sets the spacing and the prefix, obviously.
        virtual_text = {spacing = 4, prefix = '🔙'}
    })

