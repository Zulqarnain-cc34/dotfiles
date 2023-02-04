require'lspconfig'.jsonls.setup {
    -- cmd = { '/home/precision/.npm-packages/bin/vscode-json-language-server','--stdio' },

    -- Set the schema so that it can be completed in settings json file.
    -- The schemas defined in `jsonls.json` will be merged with the list configured here.
    -- on_attach = function ()
    --     local capabilities = vim.lsp.protocol.make_client_capabilities()
    --     capabilities.textDocument.completion.completionItem.snippetSupport = true
    -- end,
    --
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
    -- schemas = require("schemastore").json.schemas(),
}

