prettier = {}

local prettifycss = function()
    return {
        formatCommand = "prettier ${--tab-width:tabWidth} ${--single-quote:singleQuote} --parser css"
    }
end
local prettifyhtml = function()
    return {
        formatCommand = "prettier ${--tab-width:tabWidth} ${--single-quote:singleQuote} --parser html"
    }
end
local prettifyjson = function()
    return {
        formatCommand = "prettier ${--tab-width:tabWidth} ${--single-quote:singleQuote} --parser json"
    }
end

prettier.prettifyhtml = prettifyhtml
prettier.prettifycss = prettifycss
prettier.prettifyjson = prettifyjson

return prettier
