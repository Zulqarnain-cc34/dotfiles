-- Formatting (replaces the old, disabled efm-langserver setup).
-- conform silently skips any formatter whose binary isn't installed and
-- falls back to the LSP formatter, so listing tools that aren't present yet
-- (stylua, isort, black, gofumpt) is harmless -- install them later to enable.
require("conform").setup({
    formatters_by_ft = {
        sh = { "shfmt" },
        bash = { "shfmt" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
        go = { "gofumpt" },
    },
    formatters = {
        -- match the indentation/style the old efm shfmt config used. Use full
        -- `args` (not prepend_args) so conform's dynamic indent detection can't
        -- override the explicit `-i 4`.
        shfmt = { args = { "-i", "4", "-s", "-bn", "-filename", "$FILENAME" } },
    },
    -- No format-on-save: formatting stays manual via <leader>lf, preserving
    -- the previous workflow. The keymap passes lsp_format = "fallback" so any
    -- filetype without an installed external formatter still formats via LSP.
})
