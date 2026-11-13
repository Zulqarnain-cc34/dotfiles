-- Linting (the old efm setup did this but was disabled).
-- nvim-lint does NOT skip a linter whose binary is missing -- it tries to
-- spawn it and errors ("shellcheck: no such file or directory"). So we filter
-- to linters whose executable actually exists before running. Configured
-- linters that aren't installed yet simply stay dormant until you install them.
local lint = require("lint")

lint.linters_by_ft = {
    markdown = { "markdownlint" },
    sh = { "shellcheck" },
    bash = { "shellcheck" },
    python = { "flake8" },
    javascript = { "eslint" },
    typescript = { "eslint" },
}

-- resolve a linter's binary name (cmd can be a string or a function)
local function linter_cmd(name)
    local l = lint.linters[name]
    if type(l) == "function" then l = l() end
    local cmd = l and l.cmd
    if type(cmd) == "function" then cmd = cmd() end
    return cmd
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
    callback = function()
        local names = lint.linters_by_ft[vim.bo.filetype]
        if not names then return end
        local runnable = {}
        for _, name in ipairs(names) do
            local cmd = linter_cmd(name)
            if cmd and vim.fn.executable(cmd) == 1 then
                runnable[#runnable + 1] = name
            end
        end
        if #runnable > 0 then
            lint.try_lint(runnable)
        end
    end,
})
