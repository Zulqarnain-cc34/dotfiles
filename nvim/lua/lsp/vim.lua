-- 1. Configure the server (vimls)
vim.lsp.config['vimls'] = {
    -- If you had specific settings (like on_attach), paste them inside here.
    -- Otherwise, leave this table empty.
    init_options = {
        isNeovim = true,
    },
}

-- 2. Enable the server
vim.lsp.enable('vimls')
