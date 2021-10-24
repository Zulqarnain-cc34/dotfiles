local M={}

M.on_attach = function(client)
  require'lsp_status'.on_attach(client)
end

return M
