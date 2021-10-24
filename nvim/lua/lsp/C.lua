local lsp_status = require('lsp-status')
lsp_status.register_progress()

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").clangd.setup {
    capabilities = lsp_status.capabilities,
   on_attach = lsp_status.on_attach,
    init_options = {clangdFileStatus = true},
    handlers = lsp_status.extensions.clangd.setup()
}

-- handlers = lsp_status.extensions.clangd.setup(),
-- init_options = {
-- clangdFileStatus = true
-- },
-- on_attach = lsp_status.on_attach,
-- capabilities = lsp_status.capabilities,
-- default_config = {
-- cmd = {
-- "clangd", "--background-index", "--pch-storage=memory",
-- "--clang-tidy", "--suggest-missing-includes"
-- },
-- filetypes = {"c", "cpp", "objc", "objcpp"},
-- }
