require('lspsaga').init_lsp_saga {
    error_sign = " ",
    warn_sign = "",
    hint_sign = "",
    infor_sign = ""
}

-- local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
-- for type, icon in pairs(signs) do
--   local hl = "LspDiagnosticsSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end
--,
    --error_sign = "",
    --warn_sign = "",
    --hint_sign = "",
    --infor_sign = " "
