-- Native lsp/ config (stashed: add "dartls" to the enable list when doing Dart).
return {
    init_options = { formatting = true },
    cmd = { "dart", "/opt/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--protocol=lsp" },
}
