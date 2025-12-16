-- local luadev = require("lua-dev").setup()

-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
USER = vim.fn.expand('$USER')

-- require'lspconfig'.sumneko_lua.setup(luadev)

vim.lsp.config['lua_ls'] = {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            completion = {enable = true, callSnippet = "Both"},
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                enable = true,
                globals = {'vim', 'describe'},
                disable = {"lowercase-global"}
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua/lsp"] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. '/lua'] = true
                }
            }
        }
    }
}

vim.lsp.enable("lua_ls")
