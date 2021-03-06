local M = {}

-- vim.notify = function(msg, log_level, _opts)
-- if msg:match("exit code") then return end
-- if log_level == vim.log.levels.ERROR then
-- vim.api.nvim_err_writeln(msg)
-- else
-- vim.api.nvim_echo({{msg}}, true, {})
-- end
-- end

local efm_priority_document_format

function M.efm_priority_document_format()
    if not efm_priority_document_format then
        local clients = vim.lsp.buf_get_clients(0)
        if #clients > 1 then
            -- check if multiple clients, and if efm is setup
            for _, c1 in pairs(clients) do
                if c1.name == "efm" then
                    -- if efm then disable others
                    for _, c2 in pairs(clients) do
                        -- print(c2.name, c2.resolved_capabilities.document_formatting)
                        if c2.name ~= "efm" then
                            c2.resolved_capabilities.document_formatting = false
                        end
                    end
                    -- no need to contunue first loop
                    break
                end
            end
        end
    end
    -- no need to do above check again
    efm_priority_document_format = true
    -- format the doc
    -- TODO need a check to make sure actually has this func on one of the availble clients
    vim.lsp.buf.formatting()
end

function M.eslint_config_exists()
    local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

    if not vim.tbl_isempty(eslintrc) then return true end

    if vim.fn.filereadable("package.json") then
        if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
            return true
        end
    end

    return false
end

return M

-- function g.LspSignatureHint()
-- return vim.api.nvim_command("call vim.lsp.buf.code_action")
-- end

