require'lspconfig'.ts_ls.setup {

    cmd = {'typescript-language-server', '--stdio'},
    filetypes = {
        "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact",
        "typescript.tsx"
    },
    on_attach = function(client, bufnr)
         client.server_capabilities.document_formatting = false
         client.server_capabilities.document_range_formatting = false

        local ts_utils = require("nvim-lsp-ts-utils")

        ts_utils.setup {
            disable_commands = false,
            --enable_import_on_completion = false,
            import_on_completion_timeout = 5000,
            --update_imports_on_move = true,
        }

        ts_utils.setup_client(client)

        -- no default maps, so you may want to define some here

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lO", ":TSLspOrganize<CR>", {silent = true})

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lk", ":TSLspFixCurrent<CR>", {silent = true})

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lm", ":TSLspRenameFile<CR>", {silent = true})

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lA", ":TSLspImportAll<CR>", {silent = true})

        -- vim.api.nvim_buf_set_keymap("i", ".", ".<C-x><C-o>", nil, bufnr)
        -- vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    -- flags = {
    -- debounce_text_changes = 150,
    -- },
}
