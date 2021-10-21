local on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api
            .nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync({},1500)]]
        vim.api.nvim_command [[augroup END]]
    end
end

local eslint = require "efm/eslint"
local isort = require "efm/isort"
local flake8 = require "efm/flake"
local luafmt = require "efm/luafmt"
local shfmt = require "efm/shfmt"
local vint = require "efm/vint"
local prettier = require "efm/prettier"
local markdownlint = require "efm/markdownlint"
local gofumpt = require "efm/gofumpt"
-- local dartfmt = require "efm/dartfmt"

-- local markdownPandocFormat = require "efm/pandoc"
local markdownPandocFormat = {
    formatCommand = 'pandoc -f markdown -t gfm -sp --tab-stop=2',
    formatStdin = true
}

local shellcheck = {
    LintCommand = 'shellcheck -f gcc -x',
    lintFormats = {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'}
}

-- local asmfmt = {
-- formatCommand='asmfmt --stdin-filename ${INPUT} -w',
-- formatStdin = true
-- }

require"lspconfig".efm.setup {
    -- on_attach = on_attach,
    init_options = {documentFormatting = true, codeAction = true},
    rootdir = vim.loop.cwd,
    filetypes = {
        "lua", "python", "sh", "golang", "html", "css", "javascriptreact", "markdown", "pandoc",
        "scss", "yaml", "javascript", "javascript.jsx", "typescript", "typescript.tsx",
        "typescriptreact", "vim", "json"
    },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            sh = {shfmt, shellcheck},
            vim = {vint},
            -- dart = {dartfmt},
            lua = {luafmt},
            markdown = {markdownPandocFormat, markdownlint},
            python = {flake8, isort},
            javascript = {prettier, eslint},
            -- assembly = {asmfmt},
            go = {gofumpt},
            javascriptreact = {prettier, eslint},
            typescriptreact = {prettier, eslint},
            ["javascript.jsx"] = {prettier, eslint},
            typescript = {prettier, eslint},
            ["typescript.tsx"] = {prettier, eslint},
            pandoc = {markdownlint},
            -- html = {formatCommand="prettier ${--tab-width:tabWidth} ${--single-quote:singleQuote} --parser html",formatStdin=true},
            css = {prettier},
            scss = {prettier},
            yaml = {prettier},
            html = {prettier},
            json = {prettier, eslint}
        }
    }
}
