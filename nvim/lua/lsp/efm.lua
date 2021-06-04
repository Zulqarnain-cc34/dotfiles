local on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
        vim.api.nvim_command [[augroup END]]
    end
end

local eslint = require "efm/eslint"
-- local prettier = require "efm/prettier"
local isort = require "efm/isort"
local flake8 = require "efm/flake"
local luafmt = require "efm/luafmt"

require"lspconfig".efm.setup {
    on_attach = on_attach,
    init_options = {documentFormatting = true},
    rootdir = vim.loop.cwd,
    filetypes = {
        "lua", "python", "html", "css", "javascript", "json", "javascriptreact", "javascript.jsx",
        "typescript", "typescript.tsx", "typescriptreact"
    },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {luafmt},
            python = {flake8, isort},
            -- html = {prettier.prettifyhtml()},
            -- css = {prettier.prettifycss()},
            -- json = {prettier.prettifyjson()},
            javascript = {eslint},
            javascriptreact = {eslint},
            ["javascript.jsx"] = {eslint},
            typescript = {eslint},
            ["typescript.tsx"] = {eslint},
            typescriptreact = {eslint}
        }
    }
}
