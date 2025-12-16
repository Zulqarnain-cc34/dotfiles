-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config['html'] = {
    capabilities = capabilities,
    --init_options = {documentFormatting = false}
}

vim.lsp.enable('html')

