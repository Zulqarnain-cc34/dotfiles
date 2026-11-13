-- Native lsp/ config: custom clangd flags (not in nvim-lspconfig's default).
return {
    cmd = {
        "clangd",
        "--background-index",
        "-j=12",
        "--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
        "--clang-tidy",
        "--clang-tidy-checks=*",
        "--all-scopes-completion",
        "--completion-style=detailed",
        "--header-insertion-decorators",
        "--header-insertion=iwyu",
        "--pch-storage=memory",
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
}
