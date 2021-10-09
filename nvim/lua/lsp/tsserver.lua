-- local function organize_imports()
-- local params = {
-- command = "_typescript.organizeImports",
-- arguments = {vim.api.nvim_buf_get_name(0)},
-- title = ""
-- }
-- vim.lsp.buf.execute_command(params)
-- end
-- require'lspconfig'.tsserver.setup {
-- commands = {OrganizeImports = {organize_imports, description = "Organize Imports"}}
-- }
require'lspconfig'.tsserver.setup {

    cmd = {'typescript-language-server', '--stdio'},
    filetypes = {
        "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact",
        "typescript.tsx"
    },
    on_attach = function(client, bufnr)
         client.resolved_capabilities.document_formatting = false
         client.resolved_capabilities.document_range_formatting = false

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
