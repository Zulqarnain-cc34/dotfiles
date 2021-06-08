require'lspconfig'.tsserver.setup {
    cmd = {'typescript-language-server', '--stdio','--tsserver-path', 'node_modules/.bin/tsserver'},
    filetypes = {
        "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact",
        "typescript.tsx"
    },
}
