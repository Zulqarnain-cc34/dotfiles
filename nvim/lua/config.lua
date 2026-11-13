------------------------------------------------------------------------
--                                LSP                                 --
------------------------------------------------------------------------
require('lsp/python')
-- require('lsp/eslint')
-- require('lsp/dartls') -- Not Working
require('lsp/sqls')
require('lsp/lua_ls')
require('lsp/bash')
-- require('lsp/cmake')
require('lsp/C')
require('lsp/tsserver') -- a warning need to see and fix someday _____
require('lsp/graphql')  -- Not Working
require('lsp/html')
require('lsp/docker')
-- json LSP pulls in the full schemastore catalog (~22ms). Defer it until a
-- json file is actually opened; vim.lsp.enable then attaches to that buffer.
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "json", "jsonc" },
    once = true,
    callback = function() require('lsp/json') end,
})
-- require('lsp/gopls')
-- require('lsp/emmet')
require('lsp/vim')
-- require('lsp/lsp')

------------------------------------------------------------------------
--                              Plugins                               --
------------------------------------------------------------------------

-- require('plugins/bufferline')
-- require('plugins/nvimtree')
-- require('plugins/nvim-treesitter')
-- require('plugins/colorizer')
-- require('plugins/lspsaga')
-- require('plugins/dashboard')
---- require('plugins/lspfuzzy')
-- require('plugins/compe')
-- require('plugins/lspkind')
-- require('plugins/nvim-ts-rainbow')
----require('plugins/lsp-status')
-- require('plugins/lsp-signature-hint')
-- require('plugins/trouble')
-- require('plugins/nvim-web-devicons')
-- require('plugins/lsp-diagnostics')
-- require('plugins/todocomments')
-- require('plugins/lualine')
-- require('plugins/telescope')
-- require('plugins/nvim-dap')
--
