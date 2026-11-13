------------------------------------------------------------------------
--                                LSP                                 --
------------------------------------------------------------------------
-- Servers with custom settings each get their own module in lua/lsp/
-- (a vim.lsp.config[...] override + vim.lsp.enable). Everything else uses
-- nvim-lspconfig's shipped defaults and just needs enabling -- no module.

require('lsp/sqls')
require('lsp/lua_ls')
require('lsp/C')        -- clangd
require('lsp/tsserver') -- ts_ls
require('lsp/html')

-- json pulls in the full schemastore catalog (~22ms); defer it until a json
-- file is actually opened. vim.lsp.enable (inside the module) then attaches.
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "json", "jsonc" },
    once = true,
    callback = function() require('lsp/json') end,
})

-- No-customization servers: nvim-lspconfig provides their defaults, so just
-- enable them (no per-server file needed). pyrefly + vimls are here too --
-- their shipped defaults already match what we'd override (pyrefly's cmd, and
-- vimls' isNeovim=true), so a per-file module added nothing. Add more names as
-- you install servers (e.g. "cssls", "eslint", "cmake", "gopls", "dartls").
vim.lsp.enable({ "bashls", "dockerls", "graphql", "pyrefly", "vimls" })
