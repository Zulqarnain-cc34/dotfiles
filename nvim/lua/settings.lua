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

--g.tokyonight_style = 'storm' -- available: night, storm
--g.tokyonight_enable_italic = 1
-- g.onedark_style = 'deep'
--g.tokyonight_sidebars = {"qf", "vista_kind", "terminal", "pack"}
-- g.mkdp_auto_start = 1
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
g.tokyonight_colors = {hint = "orange", error = "#ff0000"}

g.doge_doc_standard_python = 'numpy'
g.doge_mapping = "<Leader>q"

g.gitblame_enabled = 0

g.UltiSnipsExpandTrigger = '<tab>'

g.UltiSnipsSnippetDirectories = {"UltiSnips"}

g.UltiSnipsJumpForwardTrigger = '<c-j>'

g.UltiSnipsJumpBackwardTrigger = '<c-k>'

g.user_emmet_leader_key='<C-Z>'
--g.user_emmet_install_global = 0

cmd("colorscheme one-nvim")
--cmd("colorscheme onedark")

------------------------------------------------------------------------
--                              WikiList                              --
------------------------------------------------------------------------

-- Using Markdown Sytax in favor of wikilist Syntax
-- g.vimwiki_list = {{path = '~/.config/nvim/tempdir/vimwiki/', syntax = 'markdown', ext = '.md'}}

------------------------------------------------------------------------
--                          Dev Icons Colors                          --
------------------------------------------------------------------------

