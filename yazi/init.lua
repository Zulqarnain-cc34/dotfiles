require("full-border"):setup({
    type = ui.Border.ROUNDED,
})

-- Starship prompt integration (requires: ya pkg add Rolv-Apneseth/starship)
require("starship"):setup()

-- Show user:group in status bar (Unix only)
Status:children_add(function()
    local h = cx.active.current.hovered
    if h == nil or ya.target_family() ~= "unix" then
        return ui.Line({})
    end

    return ui.Line({
        ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("#6495ED"),
        ui.Span(":"):fg("#87CEFA"),
        ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("#6495ED"),
        ui.Span(" "),
    })
end, 500, Status.RIGHT)

-- Show user@host in header (Unix only)
Header:children_add(function()
    if ya.target_family() ~= "unix" then
        return ui.Line({})
    end
    return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("#87CEFA")
end, 500, Header.LEFT)
