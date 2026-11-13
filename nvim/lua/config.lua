------------------------------------------------------------------------
--                                LSP                                 --
------------------------------------------------------------------------
-- Servers with custom settings each get their own module in lua/lsp/
-- (a vim.lsp.config[...] override + vim.lsp.enable). Everything else uses
-- nvim-lspconfig's shipped defaults and just needs enabling -- no module.

require('lsp/python')   -- pyrefly
require('lsp/sqls')
require('lsp/lua_ls')
require('lsp/C')        -- clangd
require('lsp/tsserver') -- ts_ls
require('lsp/html')
require('lsp/vim')      -- vimls

-- json pulls in the full schemastore catalog (~22ms); defer it until a json
-- file is actually opened. vim.lsp.enable (inside the module) then attaches.
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "json", "jsonc" },
    once = true,
    callback = function() require('lsp/json') end,
})

-- No-customization servers: nvim-lspconfig provides their defaults, so just
-- enable them (no per-server file needed). Add names here as you install more
-- (e.g. "cssls", "eslint", "cmake", "gopls", "emmet_language_server", "dartls").
vim.lsp.enable({ "bashls", "dockerls", "graphql" })
