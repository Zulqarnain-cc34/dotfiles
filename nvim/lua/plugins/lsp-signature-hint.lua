local cfg = {
    bind = false, -- This is mandatory, otherwise border config won't get registered.
    -- If you want to hook lspsaga or other signature handler, pls set to false
    doc_lines = 0, -- only show one line of comment set to 0 if you do not want API comments be shown

    hint_enable = true, -- virtual hint enable
    hint_prefix = "🐼 ", -- Panda for parameter
    hint_scheme = "String",
    use_lspsaga = true, -- set to true if you want to use lspsaga popup
    handler_opts = {
        border = "shadow" -- double, single, shadow, none
    },
    decorator = {"`", "`"} -- or decorator = {"***", "***"}  decorator = {"**", "**"} see markdown help

}

require"lsp_signature".on_attach(cfg)
