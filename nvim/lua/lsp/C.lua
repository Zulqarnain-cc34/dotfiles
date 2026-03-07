vim.lsp.config['clangd'] = {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=never",
    "--offset-encoding=utf-8",
  },
  root_dir = vim.lsp.util.root_pattern(
    "compile_commands.json",
    "CMakeLists.txt",
    ".git"
  ),
  filetypes = { "c", "cpp", "objc", "objcpp" },
}

vim.lsp.enable('clangd')
