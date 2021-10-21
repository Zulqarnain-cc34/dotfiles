require'lspconfig'.dartls.setup {
    init_options = {formatting = true},
    cmd = {"dart", "/opt/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--protocol=lsp"}
}
