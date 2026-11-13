-- cmd/filetypes come from nvim-lspconfig's shipped ts_ls default (which also
-- prefers a project-local node_modules/.bin binary) -- we only override on_attach.
vim.lsp.config['ts_ls'] = {
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        local opts = { silent = true, buffer = bufnr }
        -- Organize imports
        vim.keymap.set("n", "<leader>lO", function()
            vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" } } })
        end, opts)
        -- Apply first available code action (fix current issue)
        vim.keymap.set("n", "<leader>lk", function()
            vim.lsp.buf.code_action({ apply = true })
        end, opts)
        -- Add all missing imports
        vim.keymap.set("n", "<leader>lA", function()
            vim.lsp.buf.code_action({ apply = true, context = { only = { "source.addMissingImports.ts" } } })
        end, opts)
    end
    -- flags = {
    -- debounce_text_changes = 150,
    -- },
}

vim.lsp.enable('ts_ls')
