-- Native lsp/ config (stashed: add "gopls" to the enable list in config.lua
-- once you work in Go).
return {
    settings = {
        gopls = {
            analyses = { unusedparams = true },
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
