-- ${--config-precedence:configPrecedence}
return {
    formatCommand = ([[
        prettier
        ${--tab-width:tabWidth}
        ${--single-quote:singleQuote}
        ${--trailing-comma:trailingComma}
    ]]):gsub("\n", "")
}
