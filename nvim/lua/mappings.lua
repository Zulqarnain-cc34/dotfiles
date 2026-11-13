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


-- Mappings for Lsp
-- List the Info for current file specific language servers
map('n', '<Leader>lI', ':checkhealth vim.lsp<CR>', options)
-- Reload buffer to reattach LSP
map('n', '<leader>lS', '<cmd>edit<cr>', options)
-- Stops all LSP clients attached to current buffer
map('n', '<leader>lT', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_clients({bufnr=0}))<cr>', options)
-- Restarts LSP clients for current buffer
map('n', '<leader>lR', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_clients({bufnr=0})); vim.schedule(vim.cmd.edit)<cr>', options)

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
-- Format Code: conform (external formatters) with LSP formatting as fallback
map('n', '<leader>lf', '<cmd>lua require("conform").format({ async = true, lsp_format = "fallback" })<CR>', options)
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
--                        Picker (snacks.picker)                      --
------------------------------------------------------------------------

map("n", "<C-s>", "<cmd>lua Snacks.picker.files()<cr>", { noremap = true })
map("n", "<leader>fg", "<cmd>lua Snacks.picker.grep()<cr>", { noremap = true })
map("n", "<leader>fb", "<cmd>lua Snacks.picker.buffers()<cr>", { noremap = true })
map("n", "<leader>fh", "<cmd>lua Snacks.picker.help()<cr>", { noremap = true })
map("n", "<leader>fm", "<cmd>lua Snacks.picker.marks()<cr>", { noremap = true })
map("n", "<leader>fl", "<cmd>lua Snacks.picker.recent()<cr>", { noremap = true })
map("n", "<leader>fc", "<cmd>lua Snacks.picker.command_history()<cr>", { noremap = true })
map("n", "<leader>fa", "<cmd>lua Snacks.picker.man()<cr>", { noremap = true })
map("n", "<leader>fr", "<cmd>lua Snacks.picker.registers()<cr>", { noremap = true })
map("n", "<leader>Gs", "<cmd>lua Snacks.picker.git_status()<cr>", { noremap = true })

------------------------------------------------------------------------
--                           Todo comments                            --
------------------------------------------------------------------------

map("n", "<leader>tT", "<cmd>TodoTrouble<cr>", { noremap = true })
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

------------------------------------------------------------------------
--                        File Explorer (snacks)                      --
------------------------------------------------------------------------

map("n", "<C-n>", "<cmd>lua Snacks.explorer()<CR>", { noremap = true, silent = true })

------------------------------------------------------------------------
--                                Git                                 --
------------------------------------------------------------------------
-- Git is handled by Neogit (<leader>gg, defined in plugins.lua). The old
-- vim-fugitive/vim-dispatch keymaps were removed -- neither plugin is
-- installed, so :Git/:Gdiff/:Dispatch! etc. were dead.

-----------------------------------------------------------------------
--                           Miscellaneous
------------------------------------------------------------------------

map("n", "<leader><CR>", ':noh<CR>', { noremap = true, silent = true })
map("n", ";", ':', { noremap = true, silent = true })


map("n", "<leader>ss", '<cmd>set filetype=sh<CR>', { noremap = true, silent = true })
map("n", "<leader>sh", '<cmd>set filetype=bash<CR>', { noremap = true, silent = true })
