-- IMPORTANT: Check the output of :checkhealth nvim and ensure
-- nvim-treesitter is actually installed in ~/.local/share/nvim/lazy/
-- and that the 'build' step in plugins.lua is working.

require('nvim-treesitter.config').setup {
    -- The core configuration:
    ensure_installed = {
        "lua", "python", "bash", "go", "html", "css", "javascript", "json", "c", "cpp", "markdown",
        "scss", "yaml", "typescript", "vim", "dart", "fish", "java", "dockerfile"
    },
    ignore_install = {},
    autopairs = { enable = true },
    highlight = {
        enable = true
    },
    indent = { enable = true },

    -- Consolidated rainbow settings (from the old nvim-ts-rainbow.lua):
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = 1000 -- Use the highest value from your original configs
    },
}
