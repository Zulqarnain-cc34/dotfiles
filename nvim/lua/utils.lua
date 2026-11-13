local M = {}

function M.eslint_config_exists()
    -- Fixed: vim.fn.glob signature is glob(pattern, nosuf, list)
    -- nosuf should be boolean (0/1), list should be boolean (0/1)
    -- Using explicit boolean values
    local eslintrc = vim.fn.glob(".eslintrc*", false, true)
    if not vim.tbl_isempty(eslintrc) then return true end
    if vim.fn.filereadable("package.json") then
        if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
            return true
        end
    end
    return false
end
return M
