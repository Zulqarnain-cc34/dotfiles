-- following options are the default
require'nvim-tree'.setup {
    -- disables netrw completely
    disable_netrw = true,
    -- hijack netrw window on startup
    hijack_netrw = true,
    -- g.nvim_tree_auto_open = 1 -- 0 by default, opens the tree when typing `vim $DIR` or `vim`
    -- g.nvim_tree_auto_close = 1 -- 0 by default, closes the tree when it's the last window
    -- g.nvim_tree_auto_ignore_ft = 'dashboard'
    ignore_ft_on_setup = {},
    -- g.nvim_tree_follow = 1 -- 0 by default, this option allows the cursor to be updated when entering a buffer
    -- auto_close = false,
    -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
    open_on_tab = true,
    -- hijacks new directory buffers when they are opened.
    update_to_buf_dir = {
        -- g.nvim_tree_tab_open = 1 -- 0 by default, will open the tree when entering a new tab and the tree was previously open
        enable = true
        -- g.nvim_tree_disable_netrw = 0 -- 1 by default, disables netrw
        -- g.nvim_tree_hijack_netrw = 0 -- 1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
    },
    -- hijack the cursor in the tree to put it at the start of the filename
    -- g.nvim_tree_lsp_diagnostics = 1 -- 0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
    -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
    -- g.nvim_tree_hijack_cursor = 0 -- 1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
    -- show lsp diagnostics in the signcolumn
    -- lsp_diagnostics = false,
    -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    update_focused_file = {
        -- enables the feature
        enable = false,
        -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
        -- only relevant when `update_focused_file.enable` is true
        update_cwd = false,
        -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
        -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
        ignore_list = {}
    },
    -- configuration options for the system open command (`s` in the tree by default)
    system_open = {
        -- the command to run this, leaving nil should work in most cases
        cmd = nil,
        -- the command arguments as a list
        args = {}
    },

    view = {
        -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
        width = 30,
        -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
        height = 30,
        -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
        side = 'left',
        -- if true the tree will resize itself after opening a file
        auto_resize = false,
        mappings = {
            -- custom only false will merge the list with the default mappings
            -- if true, it will only use your list to set the mappings
            custom_only = false,
            -- list of mappings to set on the tree manually
            list = {}
        }
    }
}

local g = vim.g

-- g.nvim_tree_side = 'left' -- left by default
-- g.nvim_tree_width = 30-- 30 by default
-- g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'} -- empty by default
g.nvim_tree_gitignore = 1 -- 0 by default
-- g.nvim_tree_auto_open = 1 -- 0 by default, opens the tree when typing `vim $DIR` or `vim`
-- g.nvim_tree_auto_close = 1 -- 0 by default, closes the tree when it's the last window
-- g.nvim_tree_auto_ignore_ft = 'dashboard'
-- g.nvim_tree_quit_on_open = 1 -- 0 by default, closes the tree when you open a file
-- g.nvim_tree_follow = 1 -- 0 by default, this option allows the cursor to be updated when entering a buffer
g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open
g.nvim_tree_hide_dotfiles = 0 -- 0 by default, this option hides files and folders starting with a dot `.`
g.nvim_tree_git_hl = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_highlight_opened_files = 1 -- 0 by default, will enable folder and file icon highlight for opened files/directories.
g.nvim_tree_root_folder_modifier = ':~' -- This is the default. See :help filename-modifiers for more options
g.nvim_tree_width_allow_resize = 1 -- 0 by default, will not resize the tree when opening a file
-- g.nvim_tree_disable_netrw = 0 -- 1 by default, disables netrw
-- g.nvim_tree_hijack_netrw = 0 -- 1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
g.nvim_tree_add_trailing = 1 -- 0 by default, append a trailing slash to folder names
g.nvim_tree_group_empty = 1 -- 0 by default, compact folders that only contain a single folder into one node in the file tree
-- g.nvim_tree_lsp_diagnostics = 1 -- 0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
g.nvim_tree_disable_window_picker = 1 -- 0 by default, will disable the window picker.
-- g.nvim_tree_hijack_cursor = 0 -- 1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
g.nvim_tree_icon_padding = ' '
-- g.nvim_tree_update_cwd = 1 -- 0 by default, will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.
-- g.nvim_tree_window_picker_exclude = {
-- \   'filetype': [
-- \     'packer',
-- \     'qf'
-- \   ],
-- \   'buftype': [
-- \     'terminal'
-- \   ]
-- \ }
-- Dictionary of buffer option names mapped to a list of option values that
-- indicates to the window picker that the buffer's window should not be
-- selectable.
-- g.nvim_tree_special_files = [ 'README.md', 'Makefile', 'MAKEFILE' ] -- List of filenames that gets highlighted with NvimTreeSpecialFile
-- g.nvim_tree_show_icons = {git= 1,folders= 0,files= 0,folder_arrows= 0}
-- If 0, do not show the icons for one of 'git' 'folder' and 'files'
-- 1 by default, notice that if 'files' is 1, it will only display
-- if nvim-web-devicons is installed and on your runtimepath.
-- if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
-- but this will not work when you set indent_markers (because of UI conflict)

-- default will show icon by default if no icon is provided
-- default shows no icon by default

-- g.nvim_tree_icons = {

-- default = '',

-- symlink = '',

-- git = {

-- unstaged = "✗",

-- staged = "✓",

-- unmerged = "",

-- renamed = "➜",

-- untracked = "★",

-- deleted = "",

-- ignored = "◌"

-- },

-- folder = {

-- arrow_open = "",

-- arrow_cosed = "",

-- default = "",

-- open = "",

-- empty = "",

-- empty_open = "",

-- symlink = "",

-- symlink_open = ""

-- },

-- lsp = {hint = "", info = "", warning = "", error = ""}

-- }
