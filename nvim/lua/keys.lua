local g = vim.g

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- local map = function(type, key, value, mode, opts)
-- mode = mode or 'g' -- Default global mapping
-- opts = opts or {noremap = true, silent = true}
-- if mode == 'g' then
-- vim.api.nvim_set_keymap(type, key, value, opts);
-- elseif mode == 'b' then
-- vim.api.nvim_buf_set_keymap(0, type, key, value, opts);
-- end
-- end

-- ============== Leader Key =========================

g.mapleader = "m"

-- ============== Lsp Server KeyBindings ===================
local options = {noremap = true, silent = true}
-- Mappings for Lsp
-- List the Info for current file specific language servers
map('n', '<Leader>lI', ':LspInfo<CR>', options)
-- Starts the lsp server
map('n', '<leader>lS', ':LspStart<cr>', options)
-- Stops the lsp srver
map('n', '<leader>lT', ':LspStop<cr>', options)
-- Restarts the lsp Server
map('n', '<leader>lR', ':LspRestart<cr>', options)

-- ===================== Lsp KeyBindings ==================================

--  Highlights and Goto Declarations of function
map('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
-- Goto Definations of functions
map('n', '<leader>ld', '<cmd>:Lspsaga preview_definition<CR>', options)
-- Show function doc on hover
map('n', 'K', '<cmd>:Lspsaga hover_doc<CR>', options)
-- Show and goto refrences of functions
map('n', '<leader>ls', '<cmd>:Lspsaga signature_help<CR>', options)
-- Shows function implementation
map('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
-- Goto type defination
map('n', '<leader>ly', '<cmd>lua vim.lsp.buf.type_definition()<CR>', options)
-- Format Code according to file specific formatter
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', options)
-- Shows the variable and function symbols
map('n', '<leader>ds', '<cmd>:Telescope lsp_document_symbols<CR>', options)
-- Shows thw workspace Symbolj
map('n', '<leader>ws', '<cmd>:Telescope lsp_workspace_diagnostics<CR>', options)
-- Make a code action based on diagnostics
map('n', '<leader>la', '<cmd>:Lspsaga code_action<CR>', options)
-- Shows the Diagnostics of a line
map('n', '<leader>ll', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', options)
-- Bulk rename
map('n', '<leader>le', '<cmd>:Lspsaga rename<CR>', options)
-- Shows Incoming
map('n', '<leader>lc', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', options)
-- Shows Outgoing
map('n', '<leader>lo', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', options)

------------------------------------------------------------------------
--                            Neovim Compe                            --
------------------------------------------------------------------------

map('i', '<C-Space>', [[compe#complete()]], {expr = true, silent = true})
map('i', '<CR>', [[compe#confirm('<CR>')]], {expr = true, silent = true})
map('i', '<c-e>', [[compe#close('<C-e>')]], {expr = true, silent = true})
map('n', '<A-d>', '<cmd>:Lspsaga open_floaterm<CR>', options)

-- remap('t', '<A-d>', "<C-\><C-n>:Lspsaga close_floaterm<CR>", options)

------------------------------------------------------------------------
--                              Trouble                               --
------------------------------------------------------------------------

map("n", "<leader>xx", "<cmd>Trouble<cr>", {silent = true, noremap = true})
map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", {silent = true, noremap = true})
map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", {silent = true, noremap = true})
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true})
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true})
map("n", "<leader>xr", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})

------------------------------------------------------------------------
--                             Telescope                              --
------------------------------------------------------------------------

map("n", "<C-s>", "<cmd>:Telescope find_files<cr>", {noremap = true})
map("n", "<leader>fg", "<cmd>:Telescope live_grep<cr>", {noremap = true})
map("n", "<leader>fb", "<cmd>:Telescope buffers<cr>", {noremap = true})
map("n", "<leader>fh", "<cmd>:Telescope help_tags<cr>", {noremap = true})
map("n", "<leader>fm", "<cmd>:Telescope marks<cr>", {noremap = true})
map("n", "<leader>fl", "<cmd>:Telescope old_files<cr>", {noremap = true})
map("n", "<leader>fc", "<cmd>:Telescope command_history<cr>", {noremap = true})
map("n", "<leader>fa", "<cmd>:Telescope man_pages<cr>", {noremap = true})
map("n", "<leader>fr", "<cmd>:Telescope registers<cr>", {noremap = true})
-- checkout gitcommit on enter
map("n", "<leader>gg", "<cmd>:Telescope git_commits<cr>", {noremap = true})
map("n", "<leader>Gs", "<cmd>:Telescope git_status<cr>", {noremap = true})

