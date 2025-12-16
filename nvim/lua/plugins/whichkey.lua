require("which-key").setup {
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = true, -- adds help for operators like d, y,.and registers them for motion / text object completion
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      -- defer: function to control when to show popup for operators/motions
      -- Start hidden and wait for a key to be pressed before showing the popup
      -- Only used by enabled xo mapping modes.
      defer = function(ctx)
        -- The old operators = { gc = "Comments" } functionality has been removed
        -- Operators are now handled through presets.plugins.operators = true
        return ctx.mode == "V" or ctx.mode == "<C-V>"
      end,
      -- replace: Functions/Lua Patterns for formatting the labels
      replace = {
        key = {
          function(key)
            return require("which-key.view").format(key)
          end,
          -- { "<Space>", "SPC" }, -- example: replace <Space> with SPC
        },
        desc = {
          { "<Plug>%(?(.*)%)?", "%1" },
          { "^%+", "" },
          { "<[cC]md>", "" },
          { "<[cC][rR]>", "" },
          { "<[sS]ilent>", "" },
          { "^lua%s+", "" },
          { "^call%s+", "" },
          { "^:%s*", "" },
        },
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      win = {
        -- don't allow the popup to overlap with the cursor
        no_overlap = true,
        -- border, position, margin options have been removed in v3
        -- Use padding instead of margin
        padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
        title = true,
        title_pos = "center",
        zindex = 1000,
        -- Additional vim.wo and vim.bo options
        bo = {},
        wo = {
          -- winblend = 10, -- value between 0-100 for transparency
        },
      },
      layout = {
        -- height option has been removed in v3
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        -- align option has been removed in v3
      },
      -- filter: function to filter mappings (replaces ignore_missing)
      -- ignore_missing = false means show all mappings, so filter returns true for all
      filter = function(mapping)
        -- Show all mappings (equivalent to ignore_missing = false)
        return true
      end,
      show_help = true, -- show help message on the command line when the popup is visible
      -- triggers: list of trigger specifications (replaces "auto" string and triggers_blacklist)
      -- The old triggers_blacklist functionality has been removed
      triggers = {
        { "<auto>", mode = "nxso" }, -- automatically setup triggers for normal, visual, select, operator modes
      },
 }
