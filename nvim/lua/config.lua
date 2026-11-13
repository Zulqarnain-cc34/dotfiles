------------------------------------------------------------------------
--                                LSP                                 --
------------------------------------------------------------------------
-- Neovim 0.11+ native pattern: per-server overrides live in the top-level
-- lsp/ directory -- each lsp/<server>.lua returns a config table that Neovim
-- auto-discovers and merges over nvim-lspconfig's shipped default. So here we
-- only enable servers. Those without an lsp/<name>.lua file use the shipped
-- defaults as-is. Neovim reads lsp/<name>.lua lazily (when the server first
-- starts), which keeps jsonls' schemastore catalog off the startup path.
--
-- gopls/dartls/emmet_ls have stashed override files but are intentionally not
-- enabled -- add their names to the list below to turn them on.
vim.lsp.enable({
    "lua_ls", "clangd", "ts_ls", "sqls", "html",         -- override files in lsp/
    "bashls", "dockerls", "graphql", "pyrefly", "vimls", -- shipped defaults only
})

-- jsonls is deferred: enable() reads lsp/jsonls.lua eagerly, and that file
-- pulls in the full schemastore catalog (~22ms). Enable it on the first json
-- buffer instead so the catalog stays off the startup path.
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "json", "jsonc" },
    once = true,
    callback = function() vim.lsp.enable("jsonls") end,
})
