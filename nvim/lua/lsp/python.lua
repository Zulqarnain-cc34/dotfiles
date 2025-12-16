-- 1. Assign the settings
vim.lsp.config['pyright'] = {
  settings = {
    python = {
      workspaceSymbols = {
        enabled = true
      }
    }
  }
}

-- 2. Enable the server
vim.lsp.enable('pyright')
