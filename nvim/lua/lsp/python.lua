local lsp_status = require('lsp-status')
lsp_status.register_progress()

require'lspconfig'.pyright.setup{
  settings = { python = { workspaceSymbols = { enabled = true }}},
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities
}
