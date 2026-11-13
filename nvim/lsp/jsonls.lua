-- Native lsp/ config: schemastore schemas for jsonls. This file is read by
-- Neovim only when jsonls actually starts (first json/jsonc buffer), so the
-- ~22ms schemastore catalog stays off the startup path.
return {
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
    },
}
