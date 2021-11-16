-- ${--config-precedence:configPrecedence}
return {
    formatCommand = ([[
        prettier
        ${--tab-width:Tabwidth}
        ${--print-width:printWidth}
        ${--single-quote:singleQuote}
        ${--trailing-comma:trailingComma}
    ]]):gsub("\n", "")
}
