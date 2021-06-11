return {
    LintCommand = "flake8 --ignore=E501 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    formatCommand = "yapf --quiet",
    formatStdin = true
}
