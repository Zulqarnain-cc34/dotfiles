-- Native lsp/ config: sqls is installed to ~/go/bin (not on PATH), and we
-- turn on its document formatting.
return {
    cmd = { vim.env.HOME .. "/go/bin/sqls" },
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
    end,
}
