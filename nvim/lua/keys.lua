local g = vim.g

local map = function(type, key, value, mode, opts)
    mode = mode or 'g' -- Default global mapping
    opts = opts or {noremap = true, silent = true}
    if mode == 'g' then
        vim.api.nvim_set_keymap(type, key, value, opts);
    elseif mode == 'b' then
        vim.api.nvim_buf_set_keymap(0, type, key, value, opts);
    end
end

-- ============== Leader Key =========================

g.mapleader = "m"

-- ============== Lsp Server KeyBindings ====================

-- Mappings for Lsp
-- List the Info for current file specific language servers
map('n', '<Leader>lI', ':LspInfo<CR>')
-- Starts the lsp server
map('n', '<leader>lS', ':LspStart<cr>')
-- Stops the lsp srver
map('n', '<leader>lT', ':LspStop<cr>')
-- Restarts the lsp Server
map('n', '<leader>lR', ':LspRestart<cr>')

-- ===================== Lsp KeyBindings ==================================

--  Highlights and Goto Declarations of function
map('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>', 'b')
-- Goto Definations of functions
map('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', 'b')
-- Show function doc on hover
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', 'b')
-- Show and goto refrences of functions
map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', 'b')
-- Shows the function signature
map('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'b')
-- Shows function implementation
map('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', 'b')
-- Goto type defination
map('n', '<leader>ly', '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'b')
-- Format Code according to file specific formatter
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', 'b')
-- Shows the variable and function symbols
map('n', '<leader>ds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', 'b')
-- Shows thw workspace Symbols
map('n', '<leader>ws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', 'b')
-- Make a code action based on diagnostics
map('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', 'b')
-- Shows the Diagnostics of a line
map('n', '<leader>ll', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', 'b')
-- Bulk rename
map('n', '<leader>le', '<cmd>lua vim.lsp.buf.rename()<CR>', 'b')
-- Shows Incoming
map('n', '<leader>lc', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', 'b')
-- Shows Outgoing
map('n', '<leader>lo', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', 'b')
