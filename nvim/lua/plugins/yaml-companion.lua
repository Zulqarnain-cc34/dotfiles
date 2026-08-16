local cfg = require("yaml-companion").setup()
vim.lsp.config['yamlls'] = cfg
vim.lsp.enable('yamlls')
