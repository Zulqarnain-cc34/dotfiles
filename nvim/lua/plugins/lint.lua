-- Linting (the old efm setup did this but was disabled). nvim-lint silently
-- skips any linter whose binary isn't installed, so only the installed ones
-- (markdownlint) actually run today; the rest activate once installed.
local lint = require("lint")

lint.linters_by_ft = {
    markdown = { "markdownlint" },
    sh = { "shellcheck" },
    bash = { "shellcheck" },
    python = { "flake8" },
    javascript = { "eslint" },
    typescript = { "eslint" },
}

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
