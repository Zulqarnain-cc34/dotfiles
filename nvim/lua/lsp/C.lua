local lsp_status = require('lsp-status')
lsp_status.register_progress()

vim.lsp.config['clangd'] = {
    -- capabilities = lsp_status.capabilities,
   on_attach = lsp_status.on_attach,
    init_options = {clangdFileStatus = true},
    handlers = lsp_status.extensions.clangd.setup()
}


vim.lsp.enable('clangd')
