local g = vim.g

local function map(mode, lhs, rhs, opts)
    local options = { silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- ============== Leader Key =========================

g.mapleader = "m"

-- ============== Lsp Server KeyBindings ===================
local options = { noremap = true, silent = true }
local bufopts = { noremap = true, silent = true, buffer = bufnr }



-- Mappings for Lsp
-- List the Info for current file specific language servers
map('n', '<Leader>lI', ':checkhealth vim.lsp<CR>', options)
-- Reload buffer to reattach LSP
map('n', '<leader>lS', '<cmd>edit<cr>', options)
-- Stops all LSP clients attached to current buffer
map('n', '<leader>lT', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_clients({bufnr=0}))<cr>', options)
-- Restarts LSP clients for current buffer
map('n', '<leader>lR', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_clients({bufnr=0})); vim.schedule(vim.cmd.edit)<cr>', options)

map('n', '<space>dw', "<cmd>lua require('diaglist').open_all_diagnostics()<cr>", options)
map('n', '<space>do', "<cmd>lua require('diaglist').open_buffer_diagnostics()<cr>", options)

-- ===================== Lsp KeyBindings ==================================

--  Highlights and Goto Declarations of function
map('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
-- Peek definition (jump to definition)
map('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
-- Show function doc on hover
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', options)
-- Show signature help
map('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)
-- Toggle terminal (snacks)
map("n", "<A-d>", "<cmd>lua Snacks.terminal()<CR>", options)
-- Shows function implementation
map('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
-- Goto type definition
map('n', '<leader>ly', '<cmd>lua vim.lsp.buf.type_definition()<CR>', options)
-- Format Code according to file specific formatter
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', options)
-- Shows diagnostics for current buffer
map('n', '<leader>ds', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', options)
-- Shows workspace diagnostics
map('n', '<leader>ws', '<cmd>Trouble diagnostics<CR>', options)
-- Make a code action based on diagnostics
map('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', options)

-- Bulk rename
map('n', '<leader>le', '<cmd>lua vim.lsp.buf.rename()<CR>', options)
-- Shows Incoming calls
map('n', '<leader>lc', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', options)
-- Shows Outgoing calls
map('n', '<leader>lo', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', options)
-- Goto definition
map('n', '<leader>lx', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
-- Shows LSP references
map('n', '<leader>lr', '<cmd>Trouble lsp_references<cr>', options)
-- Shows quickfix list
map('n', '<leader>lq', '<cmd>Trouble qflist<cr>', options)
-- Shows diagnostics for current line
map('n', '<leader>ll', '<cmd>lua vim.diagnostic.open_float()<CR>', options)
-- Jump to next diagnostic
map('n', '<leader>ln', '<cmd>lua vim.diagnostic.goto_next()<CR>', options)
-- Jump to previous diagnostic
map('n', '<leader>lp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', options)
-- Shows diagnostics under cursor
map('n', '<leader>lb', '<cmd>lua vim.diagnostic.open_float()<CR>', options)

-- map('n', '<C-f>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', options
--
-- map('n', '<C-b>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', options)

------------------------------------------------------------------------
--                            Neovim Compe                            --
------------------------------------------------------------------------
--
-- map('i', '<A-Space>', [[compe#complete()]], {expr = true, silent = true})
-- map('i', '<CR>', [[compe#confirm('<CR>')]], {expr = true, silent = true})
-- map('i', '<c-e>', [[compe#close('<C-e>')]], {noremap = true, silent = true})
--
-- map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"',
--     {expr = true, noremap = true, silent = true})
-- map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true, noremap = true})
--
-- map('n', '<A-d>', '<cmd>Lspsaga open_floaterm<CR>', options)
--
-- -- remap('t', '<A-d>', "<C-\><C-n>:Lspsaga close_floaterm<CR>", options)

-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

------------------------------------------------------------------------
--                              Trouble                               --
------------------------------------------------------------------------

map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { silent = true, noremap = true })
map("n", "<leader>xw", "<cmd>Trouble diagnostics<cr>", { silent = true, noremap = true })
map("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { silent = true, noremap = true })
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
map("n", "<leader>xq", "<cmd>Trouble qflist<cr>", { silent = true, noremap = true })
map("n", "<leader>xr", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })

------------------------------------------------------------------------
--                             Telescope                              --
------------------------------------------------------------------------

map("n", "<C-s>", "<cmd>Telescope find_files<cr>", { noremap = true })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true })
map("n", "<leader>fm", "<cmd>Telescope marks<cr>", { noremap = true })
map("n", "<leader>fl", "<cmd>Telescope old_files<cr>", { noremap = true })
map("n", "<leader>fc", "<cmd>Telescope command_history<cr>", { noremap = true })
map("n", "<leader>fa", "<cmd>Telescope man_pages<cr>", { noremap = true })
map("n", "<leader>fr", "<cmd>Telescope registers<cr>", { noremap = true })
map("n", "<leader>Gs", "<cmd>Telescope git_status<cr>", { noremap = true })

------------------------------------------------------------------------
--                           Todo comments                            --
------------------------------------------------------------------------

map("n", "<leader>tT", "<cmd>TodoTelescope <cr>", { noremap = true })
map("n", "<leader>tq", "<cmd>TodoQuickFix<cr>", { noremap = true })
map("n", "<leader>tt", "<cmd>TodoTrouble<cr>", { noremap = true })

------------------------------------------------------------------------
--                             BUfferline                             --
------------------------------------------------------------------------

map("n", "bj", "<cmd>BufferLineCycleNext<cr>", { noremap = true, silent = true })
map("n", "bk", "<cmd>BufferLineCyclePrev<cr>", { noremap = true, silent = true })
map("n", "<leader>bn", "<cmd>BufferLineMoveNext<cr>", { noremap = true, silent = true })
map("n", "<leader>bp", "<cmd>BufferLineMovePrev<cr>", { noremap = true, silent = true })
map("n", "be", "<cmd>BufferLineSortByExtension<cr>", { noremap = true, silent = true })
map("n", "bd", "<cmd>BufferLineSortByDirectory<cr>", { noremap = true, silent = true })

--
------------------------------------------------------------------------
--                           Nvim-Dap--
------------------------------------------------------------------------

map("n", "<F5>", "<cmd>lua require 'dap'.continue()<cr>", { noremap = true, silent = true })
map("n", "<F10>", "<cmd>lua require 'dap'.step_over()<cr>", { noremap = true, silent = true })
map("n", "<F11>", "<cmd>lua require 'dap'.step_into()()<cr>", { noremap = true, silent = true })
map("n", "<F12>", "<cmd>lua require 'dap'.step_out()()<cr>", { noremap = true, silent = true })
map("n", "<leader>bb", "<cmd>lua require 'dap'.toggle_breakpoint()<cr>",
    { noremap = true, silent = true })
map("n", "<leader>B", ":lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })

-- map("n", "<leader>lp", ":lua require 'dap'.run_last()<cr>", {noremap = true, silent = true})
map("n", "<leader>dr",
    "<cmd>lua require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
    { noremap = true, silent = true })

-- map("n", "<leader>dl",
-- map("n", "<leader>dl",
-- "<cmd>lua require 'dap'.set_breakpoint(nil,nil,vim.fn.input('Log point message: '))<cr>",
-- map("v", "<leader>rs", "<cmd>lua require 'dap-python'.debug_selection()<cr>",

------------------------------------------------------------------------
--                           Nvim Tree--
------------------------------------------------------------------------

map("n", "<C-n>", "<CMD>Oil<CR>", { noremap = true, silent = true })
------------------------------------------------------------------------
--                                Git                                 --
------------------------------------------------------------------------


map("n", "<leader>ga", "<cmd>Git add %:p<CR>", { noremap = true, silent = true })
map("n", "<leader>gs", "<cmd>Git<CR>", { noremap = true, silent = true })
map("n", "<leader>gc", "<cmd>Git commit -v -q<CR>", { noremap = true, silent = true })
map("n", "<leader>gt", "<cmd>Git commit -v -q %:p<CR>", { noremap = true, silent = true })
map("n", "<leader>gd", "<cmd>Gdiff<CR>", { noremap = true, silent = true })
map("n", "<leader>ge", "<cmd>Gedit<CR>", { noremap = true, silent = true })
map("n", "<leader>gr", "<cmd>Gread<CR>", { noremap = true, silent = true })
map("n", "<leader>gw", "<cmd>Gwrite<CR>", { noremap = true, silent = true })
map("n", "<leader>gl", "<cmd>silent! Glog<CR>:bot copen<CR>", { noremap = true, silent = true })
map("n", "<leader>gp", "<cmd>Ggrep<Space>", { noremap = true, silent = true })
map("n", "<leader>gb", "<cmd>Gmove<Space>", { noremap = true, silent = true })
map("n", "<leader>go", "<cmd>Git branch<Space>", { noremap = true, silent = true })
map("n", "<leader>gps", "<cmd>Git checkout<Space>", { noremap = true, silent = true })
map("n", "<leader>gpu", "<cmd>Dispatch! git push<CR>", { noremap = true, silent = true })
map("n", "<leader>gpl", "<cmd>Dispatch! git pull<CR>", { noremap = true, silent = true })

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

map("n", "<leader>bg", '<cmd>ToggleBlameLine<CR>', { noremap = true, silent = true })
map("n", "<leader><CR>", ':noh<CR>', { noremap = true, silent = true })
map("n", ";", ':', { noremap = true, silent = true })


map("n", "<leader>ss", '<cmd>set filetype=sh<CR>', { noremap = true, silent = true })
map("n", "<leader>sh", '<cmd>set filetype=bash<CR>', { noremap = true, silent = true })


------------------------------------------------------------------------
--                                 WhichKey                           --
------------------------------------------------------------------------

-- map("n", "<leader>", ':WhichKey <leader><CR>', {noremap = true, silent = true})

-- " Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
-- map <space> /
-- map <C-space> ?


-- map("n", "<space>", "/", {})
