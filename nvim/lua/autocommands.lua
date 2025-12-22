-- ============================================================================
-- File Runner Keybindings
-- ============================================================================
-- using F9 key in normal mode

local keymap_opts = { noremap = true, silent = true }

-- Create augroup for file runners to avoid duplicate autocommands
local runner_group = vim.api.nvim_create_augroup('FileRunners', { clear = true })

-- Python: Run current file
vim.api.nvim_create_autocmd('FileType', {
    group = runner_group,
    pattern = 'python',
    callback = function()
        vim.keymap.set('n', '<F9>', ':!python %<CR>', keymap_opts)
    end,
    desc = 'Run Python file with F9'
})

-- C++: Compile and run
vim.api.nvim_create_autocmd('FileType', {
    group = runner_group,
    pattern = 'cpp',
    callback = function()
        vim.keymap.set('n', '<F9>', ':!g++ % -o %:r && ./%:r<CR>', keymap_opts)
    end,
    desc = 'Compile and run C++ file with F9'
})

-- JavaScript: Run with Node.js
vim.api.nvim_create_autocmd('FileType', {
    group = runner_group,
    pattern = 'javascript',
    callback = function()
        vim.keymap.set('n', '<F9>', ':!node %<CR>', keymap_opts)
    end,
    desc = 'Run JavaScript file with Node.js'
})

-- Shell scripts: Execute with bash
vim.api.nvim_create_autocmd('FileType', {
    group = runner_group,
    pattern = 'sh',
    callback = function()
        vim.keymap.set('n', '<F9>', ':!bash %<CR>', keymap_opts)
    end,
    desc = 'Run shell script with bash'
})

-- C: Compile and run
vim.api.nvim_create_autocmd('FileType', {
    group = runner_group,
    pattern = 'c',
    callback = function()
        vim.keymap.set('n', '<F9>', ':!gcc % -o %:r && ./%:r<CR>', keymap_opts)
    end,
    desc = 'Compile and run C file with F9'
})

-- TypeScript: Run with ts-node
vim.api.nvim_create_autocmd('FileType', {
    group = runner_group,
    pattern = 'typescript',
    callback = function()
        vim.keymap.set('n', '<F9>', ':!ts-node %<CR>', keymap_opts)
    end,
    desc = 'Run TypeScript file with ts-node'
})

-- ============================================================================
-- Cursor Position Restoration
-- ============================================================================

vim.api.nvim_create_autocmd('BufReadPost', {
    group = vim.api.nvim_create_augroup('RestoreCursor', { clear = true }),
    pattern = '*',
    callback = function()
        local line = vim.fn.line("'\"")
        if line > 1 and
            line <= vim.fn.line("$") and
            vim.bo.filetype ~= 'commit' and
            vim.fn.index({ 'xxd', 'gitrebase', 'help' }, vim.bo.filetype) == -1 then
            vim.cmd('normal! g`"')
        end
    end,
    desc = 'Restore cursor position'
})

-- ============================================================================
-- File Switching Configuration (FSwitchDst)
-- ============================================================================
-- Description: Configure header/source file switching for C/C++ development

local fswitch_group = vim.api.nvim_create_augroup('FileSwitching', { clear = true })

-- Header files: switch to C/C++ source files
vim.api.nvim_create_autocmd('BufEnter', {
    group = fswitch_group,
    pattern = '*.h',
    callback = function()
        vim.b.fswitchdst = 'c,cpp,cc,m'
    end,
    desc = 'Configure file switching for header files'
})

-- C++ source files: switch to header files
vim.api.nvim_create_autocmd('BufEnter', {
    group = fswitch_group,
    pattern = '*.cc',
    callback = function()
        vim.b.fswitchdst = 'h,hpp'
    end,
    desc = 'Configure file switching for C++ source files'
})

-- ============================================================================
-- Syntax Highlighting: Comment Color Customization
-- ============================================================================
-- Description: Set custom color for comments

-- Set comment color (adjust to your preference)
vim.api.nvim_set_hl(0, 'Comment', { fg = '#968d8c' })
