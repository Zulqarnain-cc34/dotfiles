-- =========================================================================
--      ____                           _   ____       _   _   _
--    / ___| ___ _ __   ___ _ __ __ _| | / ___|  ___| |_| |_(_)_ __   __ _ ___
--  | |  _ / _ \ '_ \ / _ \ '__/ _` | | \___ \ / _ \ __| __| | '_ \ / _` / __|
-- | |_| |  __/ | | |  __/ | | (_| | |  ___) |  __/ |_| |_| | | | | (_| \__ \
-- \____|\___|_| |_|\___|_|  \__,_|_| |____/ \___|\__|\__|_|_| |_|\__, |___/
--                                                                |___/
--
--=========================================================================

-- ================== Aliases ========================

local g = vim.g
local o = vim.o
local b = vim.bo
local w = vim.wo
local cmd = vim.api.nvim_command

-- ============== Commands =====================

cmd("syntax enable")
cmd("filetype plugin on")
cmd("filetype plugin indent on")

-- ============== Basic   ==========================

o.termguicolors = true	-- Allows coloring support and themes colors
o.compatible = false    -- ompromising compatibilty
o.fileencoding= "utf-8" -- The encoding written to file
o.undolevels = 1000     -- use many muchos levels of undo
o.title = true          -- change the terminal's title
o.visualbell = true     -- don't beep
o.backup = false        -- Some servers shave issues with backups
o.cmdheight = 2     	-- Bigger messages display. command line height
o.updatetime = 200  	-- Faster diagnostic messages (defaults 4000)
o.mouse = 'a'       	-- Enable mouse support
o.wildignore = '*.swp,*.bak,*.pyc,*.class'
o.backspace = 'indent,eol,start'  -- allow back spacing over everything in insert mode
w.wrap = true           -- wrap lines
w.list = true
w.number = true         -- Setting up number line
w.relativenumber = true -- Setting relative number line
w.listchars = 'tab:>.,trail:.,extends:#,nbsp:.'
o.showmatch = true     -- set show matching parenthesis
o.history = 1000       -- remember more commands and search history
o.lazyredraw = true    -- Don't redraw while executing macros (good performance config)
o.magic = true         -- For regular expressions turn magic on

o.conceallevel = 0     -- So that I can see `` in markdown files
o.shiftround = true    -- use multiple of shiftwidth when indenting with '<' and '>'
o.whichwrap = '<,>,h,l'-- Allows moving between lines by hitting the end and start
b.undofile = true      -- Maintain undo history between sessions
o.undodir = '/home/precision/.config/nvim/tempdir/undodir'
o.shortmess = o.shortmess.."c"   -- Don't pass messages to |ins-completion-menu|.
o.expandtab = true     -- Converts tabs to spaces
o.ttyfast = true       -- fast scrolling
o.pastetoggle = "<F2>"

-- ============== Search =============================

o.ignorecase = true    -- Ignorecase when searching
o.incsearch = true     -- start searching on each keystroke
o.smartcase = true     -- ignore case when lowercase, match case when capital case is used
o.hlsearch = true      -- highlight the search results
--o.mat = 1              -- How many tenths of a second to blink when matching brackets

-- =============== Completion ========================

o.wildmenu = true
o.wildmode = 'longest:full,full'

-- ================= Indentation ================= --

b.autoindent = true    -- copy the previous indentation on autoindenting
b.smartindent = true   -- always set autoindenting on
b.shiftwidth = 4       -- number of spaces to use for autoindenting
o.smarttab = true      -- insert tabs on the start of a line according to shiftwidth, not tabstop
