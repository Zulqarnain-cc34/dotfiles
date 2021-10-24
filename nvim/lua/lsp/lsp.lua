local nvim_lsp = require("lspconfig")

local servers = {
    'gopls',  'tsserver', 'jsonls', 'clangd','bashls','sumneko_lua'
}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {on_attach = require("plugins.on_attach").on_attach()}
end
