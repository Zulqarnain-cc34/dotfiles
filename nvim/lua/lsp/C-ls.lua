local lsp_status = require('lsp-status')
lsp_status.register_progress()

require("lspconfig").clangd.setup {
    handlers = lsp_status.extensions.clangd.setup(),
    init_options = {
	clangdFileStatus = true
    },
    on_attach = lsp_status.on_attach,
    capabilities = lsp_status.capabilities,
    default_config = {	
        cmd = {
            "clangd", "--background-index", "--pch-storage=memory",
            "--clang-tidy", "--suggest-missing-includes"
        },
        filetypes = {"c", "cpp", "objc", "objcpp"},
    }
}
