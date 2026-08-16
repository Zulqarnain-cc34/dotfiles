vim.lsp.config['gopls'] = {
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod" },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            linksInHover = false,
            codelenses = {
                generate = true,
                gc_details = true,
                regenerate_cgo = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
            usePlaceholders = true,
        },
    },
}

vim.lsp.enable('gopls')
