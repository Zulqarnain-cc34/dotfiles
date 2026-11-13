-- Native lsp/ config: only override on_attach. cmd/filetypes come from
-- nvim-lspconfig's shipped ts_ls default (it prefers a project-local
-- node_modules/.bin binary, which we want to keep).
return {
    on_attach = function(client, bufnr)
        -- let conform/prettier own formatting, not tsserver
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        local opts = { silent = true, buffer = bufnr }
        -- Organize imports
        vim.keymap.set("n", "<leader>lO", function()
            vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" } } })
        end, opts)
        -- Apply first available code action
        vim.keymap.set("n", "<leader>lk", function()
            vim.lsp.buf.code_action({ apply = true })
        end, opts)
        -- Add all missing imports
        vim.keymap.set("n", "<leader>lA", function()
            vim.lsp.buf.code_action({ apply = true, context = { only = { "source.addMissingImports.ts" } } })
        end, opts)
    end,
}
