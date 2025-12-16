local M = {}
local efm_priority_document_format

function M.efm_priority_document_format()
    if not efm_priority_document_format then
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients > 1 then
            for _, c1 in pairs(clients) do
                if c1.name == "efm" then
                    -- if efm then disable others
                    for _, c2 in pairs(clients) do
                        -- print(c2.name, c2.server_capabilities.documentFormattingProvider)
                        if c2.name ~= "efm" then
                            c2.server_capabilities.documentFormattingProvider = false
                        end
                    end
                    break
                end
            end
        end
    end
    efm_priority_document_format = true
    -- Fixed: use new vim.lsp.buf.format() API instead of deprecated buf.formatting()
    vim.lsp.buf.format()
end

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
