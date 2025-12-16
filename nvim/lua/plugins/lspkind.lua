local config = {
    -- enables text annotations
    mode = true,

    -- default symbol map
    preset = 'codicons',

    -- override preset symbols (your custom map)
    symbol_map = {
        Text = '',
        Method = 'ƒ',
        Function = '',
        Constructor = '',
        Variable = '',
        Class = ' ',
        Interface = ' ',
        Module = ' ',
        Property = '',
        Unit = '',
        Value = '',
        Enum = '了',
        Keyword = '',
        Snippet = '﬌',
        Color = '',
        File = '',
        Folder = '',
        EnumMember = '',
        Constant = '',
        Struct = ''
    },
}
require('lspkind').init(config)
