vim.notify = function(msg, log_level, _opts)
    if msg:match("exit code") then return end
    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
        vim.api.nvim_echo({{msg}}, true, {})
    end
end

function vim.g.LspSignatureHint()
    return vim.api.nvim_command("call vim.lsp.buf.code_action")
end

