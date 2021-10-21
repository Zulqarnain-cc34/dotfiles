require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "lua", "python", "bash", "go", "html", "css", "javascript", "json","c","cpp",
         "scss", "yaml", "typescript", "vim","dart","fish","java","dockerfile"
    }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = {}, -- List of parsers to ignore installing
    autopairs = {enable = true},
    highlight = {
        enable = true -- false will disable the whole extension
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = 1000 -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    indent = {enable = true}
}
