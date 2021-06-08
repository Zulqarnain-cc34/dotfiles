-- ====================================
-- |  _ \| |_   _  __ _(_)_ __  ___
-- | |_) | | | | |/ _` | | '_ \/ __|
-- |  __/| | |_| | (_| | | | | \__ \
-- |_|   |_|\__,_|\__, |_|_| |_|___/
--                |___/
-- ===================================
local cmd = vim.cmd
local g = vim.g

------------------------------------------------------------------------
--                               Theme                                --
------------------------------------------------------------------------

g.tokyonight_style = 'storm' -- available: night, storm
g.tokyonight_enable_italic = 1
g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
--g.onedark_style = 'deep'
-- Auto starts Markdown buffer
--g.mkdp_auto_start = 1

cmd("colorscheme tokyonight")

------------------------------------------------------------------------
--                              WikiList                              --
------------------------------------------------------------------------

-- Using Markdown Sytax in favor of wikilist Syntax
g.vimwiki_list = {{path = '~/.config/nvim/tempdir/vimwiki/', syntax = 'markdown', ext = '.md'}}

------------------------------------------------------------------------
--                          Dev Icons Colors                          --
------------------------------------------------------------------------
--
