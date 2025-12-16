local on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                -- Fixed: use new vim.lsp.buf.format() API instead of deprecated buf.formatting()
                vim.lsp.buf.format()
            end,
            group = vim.api.nvim_create_augroup("EfmFormat", { clear = true }),
        })
    end
end

-- Imports
local eslint = require "efm/eslint"
local isort = require "efm/isort"
local flake8 = require "efm/flake"
local luafmt = require "efm/luafmt"
-- local shfmt = require "efm/shfmt"
local vint = require "efm/vint"
local prettier = require "efm/prettier"
-- local markdownlint = require "efm/markdownlint"
local gofumpt = require "efm/gofumpt"
local luacheck = require "efm/luacheck"
local cppcheck = require "efm/cppcheck"
-- local dartfmt = require "efm/dartfmt"


-- 1. Configure EFM
vim.lsp.config['efm'] = {
    on_attach = on_attach,
    init_options = { documentFormatting = true },
    -- root_dir = vim.loop.cwd, -- note: fixed spelling from 'rootdir' to 'root_dir'
    filetypes = {
        "lua", "python", "sh", "golang", "html", "markdown", "scss", "yaml",
        "javascript.jsx", "typescript", "typescript.tsx", "typescriptreact", "vim", "json", "c",
        "cpp"
    },
    flags = {
        exit_timeout = false, -- or set to a low number like 100 (ms)
    },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            c = {cppcheck},
            cpp = {cppcheck},
            -- sh = {shfmt},
            vim = {vint},
            -- dart = {dartfmt},
            lua = {luafmt, luacheck},
            -- markdown = {markdownPandocFormat, markdownlint},
            javascript = {eslint},
            python = {flake8, isort},
            go = {gofumpt},
            javascriptreact = {prettier, eslint},
            typescriptreact = {prettier, eslint},
            ["javascript.jsx"] = {prettier, eslint},
            typescript = {prettier, eslint},
            ["typescript.tsx"] = {prettier, eslint},
            scss = {prettier},
            yaml = {prettier},
            html = {prettier},
            json = {prettier, eslint}
        }
    }
}

-- 2. Enable EFM
vim.lsp.enable('efm')
