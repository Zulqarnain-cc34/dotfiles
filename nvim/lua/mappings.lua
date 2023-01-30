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
local bufopts = { noremap=true, silent=true, buffer=bufnr }
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
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format{ async:true }<CR>', options)
-- Shows the variable and function symbols
map('n', '<leader>ds', '<cmd>:Trouble lsp_document_diagnostics<CR>', options)
-- Shows thw workspace Symbolj
map('n', '<leader>ws', '<cmd>:Trouble lsp_workspace_diagnostics<CR>', options)
-- Make a code action based on diagnostics
map('n', '<leader>la', '<cmd>:Lspsaga code_action<CR>', options)

vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, bufopts)

-- map('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', options)
-- Bulk rename
map('n', '<leader>le', '<cmd>:Lspsaga rename<CR>', options)
-- Shows Incoming
map('n', '<leader>lc', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', options)
-- Shows Outgoing
map('n', '<leader>lo', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', options)
-- Shows Outgoing
map('n', '<leader>lx', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
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

map('i', '<A-Space>', [[compe#complete()]], {expr = true, silent = true})
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
--                           ChatGPT
------------------------------------------------------------------------
map("n", "<leader>c", "<cmd>:ChatGPT<cr>", {noremap = true, silent = true})
--
--
------------------------------------------------------------------------
--                           Nvim-Dap--
------------------------------------------------------------------------

map("n", "<F5>", "<cmd>:lua require 'dap'.continue()<cr>", {noremap = true, silent = true})
map("n", "<F10>", "<cmd>:lua require 'dap'.step_over()<cr>", {noremap = true, silent = true})
map("n", "<F11>", "<cmd>:lua require 'dap'.step_into()()<cr>", {noremap = true, silent = true})
map("n", "<F12>", "<cmd>:lua require 'dap'.step_out()()<cr>", {noremap = true, silent = true})
map("n", "<leader>bb", "<cmd>:lua require 'dap'.toggle_breakpoint()<cr>",
    {noremap = true, silent = true})
map("n", "<leader>B", ":lua require'dap'.repl.open()<CR>", {noremap = true, silent = true})

-- map("n", "<leader>lp", ":lua require 'dap'.run_last()<cr>", {noremap = true, silent = true})
map("n", "<leader>dr",
    "<cmd>:lua require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
    {noremap = true, silent = true})

-- map("n", "<leader>dl",
-- map("n", "<leader>dl",
-- "<cmd>:lua require 'dap'.set_breakpoint(nil,nil,vim.fn.input('Log point message: '))<cr>",
-- map("v", "<leader>rs", "<cmd>:lua require 'dap-python'.debug_selection()<cr>",

------------------------------------------------------------------------
--                           Nvim Tree--
------------------------------------------------------------------------

map("n", "<C-n>", "<cmd>:NvimTreeToggle<CR>", {noremap = true, silent = true})
map("n", "<leader>nr", "<cmd>:NvimTreeRefresh<CR>", {noremap = true, silent = true})

------------------------------------------------------------------------
--                                Git                                 --
------------------------------------------------------------------------


map("n", "<leader>ga", "<cmd>:Git add %:p<CR>", {noremap = true, silent = true})
map("n", "<leader>gs", "<cmd>:Git<CR>", {noremap = true, silent = true})
map("n", "<leader>gc", "<cmd>:Git commit -v -q<CR>", {noremap = true, silent = true})
map("n", "<leader>gt", "<cmd>:Git commit -v -q %:p<CR>", {noremap = true, silent = true})
map("n", "<leader>gd", "<cmd>:Gdiff<CR>", {noremap = true, silent = true})
map("n", "<leader>ge", "<cmd>:Gedit<CR>", {noremap = true, silent = true})
map("n", "<leader>gr", "<cmd>:Gread<CR>", {noremap = true, silent = true})
map("n", "<leader>gw", "<cmd>:Gwrite<CR>", {noremap = true, silent = true})
map("n", "<leader>gl", "<cmd>:silent! Glog<CR>:bot copen<CR>", {noremap = true, silent = true})
map("n", "<leader>gp", "<cmd>:Ggrep<Space>", {noremap = true, silent = true})
map("n", "<leader>gb", "<cmd>:Gmove<Space>", {noremap = true, silent = true})
map("n", "<leader>go", "<cmd>:Git branch<Space>", {noremap = true, silent = true})
map("n", "<leader>gps", "<cmd>:Git checkout<Space>", {noremap = true, silent = true})
map("n", "<leader>gpl", "<cmd>:Dispatch! git push<CR>", {noremap = true, silent = true})
map("n", "<leader>gpl", "<cmd>:Dispatch! git pull<CR>", {noremap = true, silent = true})

-- nnoremap <leader>ga :Git add %:p<CR><CR>
-- nnoremap <leader>gs :Gstatus<CR>
-- nnoremap <leader>gc :Gcommit -v -q<CR>
-- nnoremap <leader>gt :Gcommit -v -q %:p<CR>
-- nnoremap <leader>gd :Gdiff<CR>
-- nnoremap <leader>ge :Gedit<CR>
-- nnoremap <leader>gr :Gread<CR>
-- nnoremap <leader>gw :Gwrite<CR><CR>
-- nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
-- nnoremap <leader>gp :Ggrep<Space>
-- nnoremap <leader>gm :Gmove<Space>
-- nnoremap <leader>gb :Git branch<Space>
-- nnoremap <leader>go :Git checkout<Space>
-- nnoremap <leader>gps :Dispatch! git push<CR>
-- nnoremap <leader>gpl :Dispatch! git pull<CR>


-----------------------------------------------------------------------
--                           Macros
------------------------------------------------------------------------
-- map("i", "<Space>", '<C-o>1z=<C-o>e<C-o>A<Space>', {noremap = true, silent = true})
-- map("n", "<leader>q,", 'i"<ESC>ewwi"<ESC>', {noremap = true, silent = true})

-----------------------------------------------------------------------
--                           Miscellinious
------------------------------------------------------------------------

map("n", "<leader>bg", '<cmd>:ToggleBlameLine<CR>', {noremap = true, silent = true})
map("n", "<leader><CR>", ':noh<CR>', {noremap = true, silent = true})
map("n", ";", ':', {noremap = true, silent = true})


map("n", "<leader>ss", '<cmd>:set filetype=sh>CR>', {noremap = true, silent = true})
map("n", "<leader>sh", '<cmd>:set filetype=bash<CR>', {noremap = true, silent = true})

-----------------------------------------------------------------------
--                          C++ Switching h and cpp files
------------------------------------------------------------------------

map("n", "<A-o>", ':FSHere', {noremap = true, silent = true})
-- Extra hotkeys to open header/source in the split
map("n", "<leader>oh", ':FSSplitLeft<CR>', {noremap = true, silent = true})
map("n", "<leader>oj", ':FSSplitBelow<CR>', {noremap = true, silent = true})
map("n", "<leader>ok", ':FSSplitAbove<CR>', {noremap = true, silent = true})
map("n", "<leader>ol", ':FSSplitRight<CR>', {noremap = true, silent = true})

map("n", "<leader>ol", ':FSSplitRight<CR>', {noremap = true, silent = true})

------------------------------------------------------------------------
--                                 WhichKey                           --
------------------------------------------------------------------------

-- map("n", "<leader>", ':WhichKey <leader><CR>', {noremap = true, silent = true})

-- " Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
-- map <space> /
-- map <C-space> ?


-- map("n", "<space>", "/", {})
