-- 1. Configure the server
vim.lsp.config['sqls'] = {
    cmd = { vim.env.HOME .. "/go/bin/sqls" },
    on_attach = function(client, bufnr)
        -- Enable formatting if you want it
        client.server_capabilities.documentFormattingProvider = true
    end,
}

-- 2. Enable the server
vim.lsp.enable('sqls')
