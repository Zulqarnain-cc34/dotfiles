return {
    LintCommand = "flake8 --ignore=E581 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    formatCommand = "yapf --quiet",
    formatStdin = true
}
