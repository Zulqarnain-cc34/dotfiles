
return {
    lintcommand = 'markdownlint -s -c ./markdownlintrc',
    lintStdin = true,
    lintFormats = {'%f:%l %m', '%f:%l:%c %m', '%f: %l: %m'}
}
