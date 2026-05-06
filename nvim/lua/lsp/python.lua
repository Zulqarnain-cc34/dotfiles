-- 1. Assign the settings
-- vim.lsp.config['pyright'] = {
--   settings = {
--     python = {
--       workspaceSymbols = {
--         enabled = true
--       }
--     }
--   }
-- }
--
-- -- 2. Enable the server
-- --
vim.lsp.config('pyrefly', {
    cmd = { 'pyrefly', 'lsp' }, -- use system pyrefly-bin
    filetypes = { 'python' },
})

vim.lsp.enable('pyrefly')
