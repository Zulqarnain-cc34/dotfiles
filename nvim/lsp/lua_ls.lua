-- Native lsp/ config (Neovim 0.11+): returns a table merged over
-- nvim-lspconfig's shipped lua_ls default. Enable in config.lua.
-- lazydev.nvim already wires the workspace library + the `vim` global for
-- editing this config; the workspace/runtime bits are belt-and-suspenders
-- so lua_ls is also sane when editing Lua outside the Neovim config.
return {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            completion = { enable = true, callSnippet = "Both" },
            diagnostics = {
                enable = true,
                globals = { 'vim', 'describe' },
                disable = { "lowercase-global" },
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.stdpath("config") .. '/lua'] = true,
                },
            },
        },
    },
}
