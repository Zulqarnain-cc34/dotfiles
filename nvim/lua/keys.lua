local g = vim.g

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

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
map('n', '<leader>ds', '<cmd>:Trouble lsp_document_diagnostics<CR>', options)
-- Shows thw workspace Symbolj
map('n', '<leader>ws', '<cmd>:Trouble lsp_workspace_diagnostics<CR>', options)
-- Make a code action based on diagnostics
map('n', '<leader>la', '<cmd>:Lspsaga code_action<CR>', options)
-- Bulk rename
map('n', '<leader>le', '<cmd>:Lspsaga rename<CR>', options)
-- Shows Incoming
map('n', '<leader>lc', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', options)
-- Shows Outgoing
map('n', '<leader>lo', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', options)
-- Shows Outgoing
map('n', '<leader>lx', '<cmd>lua vim.lsp.buf.definition()()<CR>', options)
-- Shows Outgoing
map('n', '<leader>lr', '<cmd>Trouble lsp_references<cr>', options)
-- Shows Outgoing
map('n', '<leader>lq', '<cmd>Trouble quickfix<cr>', options)
-- Shows the next diagnostic of a line
map('n', '<leader>ll', '<cmd>:Lspsaga show_line_diagnostics<CR>', options)
-- Shows the Diagnostics of a line
map('n', '<leader>ln', '<cmd>:Lspsaga diagnostic_jump_next<CR>', options)
-- Shows the Diagnostics of a line
map('n', '<leader>lp', '<cmd>:Lspsaga diagnostic_jump_prev<CR>', options)

map('n', '<leader>lb', '<cmd>:Lspsaga show_cursor_diagnostics<CR>', options)

map('n', '<C-f>', '<cmd>:lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', options)

map('n', '<C-b>', '<cmd>:lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', options)
------------------------------------------------------------------------
--                            Neovim Compe                            --
------------------------------------------------------------------------

map('i', '<C-Space>', [[compe#complete()]], {expr = true, silent = true})
map('i', '<CR>', [[compe#confirm('<CR>')]], {expr = true, silent = true})
map('i', '<c-e>', [[compe#close('<C-e>')]], {noremap = true, silent = true})

map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"',
    {expr = true, noremap = true, silent = true})
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true, noremap = true})

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
map("n", "<leader>gg", "<cmd>:Telescope git_commits<cr>", {noremap = true})
map("n", "<leader>Gs", "<cmd>:Telescope git_status<cr>", {noremap = true})

------------------------------------------------------------------------
--                           Todo comments                            --
------------------------------------------------------------------------

map("n", "<leader>tT", "<cmd>:TodoTelescope <cr>", {noremap = true})
map("n", "<leader>tq", "<cmd>:TodoQuickFix<cr>", {noremap = true})
map("n", "<leader>tt", "<cmd>:TodoTrouble<cr>", {noremap = true})

------------------------------------------------------------------------
--                              JABS--
------------------------------------------------------------------------

map("n", "<leader>j", "<cmd>:JABSOpen<cr>", {noremap = true})

------------------------------------------------------------------------
--                             BUfferline                             --
------------------------------------------------------------------------

map("n", "bj", "<cmd>:BufferLineCycleNext<cr>", {noremap = true, silent = true})
map("n", "bk", "<cmd>:BufferLineCyclePrev<cr>", {noremap = true, silent = true})
map("n", "<leader>bn", "<cmd>:BufferLineMoveNext<cr>", {noremap = true, silent = true})
map("n", "<leader>bp", "<cmd>:BufferLineMovePrev<cr>", {noremap = true, silent = true})
map("n", "be", "<cmd>:BufferLineSortByExtension<cr>", {noremap = true, silent = true})
map("n", "bd", "<cmd>:BufferLineSortByDirectory<cr>", {noremap = true, silent = true})

------------------------------------------------------------------------
--                           Miscellenious                            --
------------------------------------------------------------------------

map("n", "<F5>", "<cmd>:lua require 'dap'.continue()<cr>", {noremap = true, silent = true})
map("n", "<F10>", "<cmd>:lua require 'dap'.step_over()<cr>", {noremap = true, silent = true})
map("n", "<F11>", "<cmd>:lua require 'dap'.step_into()()<cr>", {noremap = true, silent = true})
map("n", "<F12>", "<cmd>:lua require 'dap'.step_out()()<cr>", {noremap = true, silent = true})
map("n", "<leader>bb", "<cmd>:lua require 'dap'.toggle_breakpoint()<cr>",
    {noremap = true, silent = true})
map("n", "<leader>B", ":lua require'dap'.repl.open()<CR>", {noremap = true, silent = true})
map("n", "<leader>lp", ":lua require 'dap'.run_last()<cr>", {noremap = true, silent = true})
map("n", "<leader>dr",
    "<cmd>:lua require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
    {noremap = true, silent = true})

-- map("n", "<leader>dl",
-- map("n", "<leader>dl",
-- "<cmd>:lua require 'dap'.set_breakpoint(nil,nil,vim.fn.input('Log point message: '))<cr>",
-- map("v", "<leader>rs", "<cmd>:lua require 'dap-python'.debug_selection()<cr>",
-- {noremap = true, silent = true})


------------------------------------------------------------------------
--                           Nvim Tree--
------------------------------------------------------------------------


map("n", "<C-n>", "<cmd>:NvimTreeToggle<CR>", {noremap = true, silent = true})
map("n", "<leader>nr", "<cmd>:NvimTreeRefresh<CR>", {noremap = true, silent = true})
map("n", "<leader>nf", "<cmd>:NvimTreeFindFile<CR>", {noremap = true, silent = true})



