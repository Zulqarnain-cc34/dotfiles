require("bufferline").setup {
    options = {
        indicator_icon = '▎',
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 20,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, _)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        show_buffer_icons = true,
        offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center" }},
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        always_show_bufferline = true,
        custom_areas = {
          right = function()
            local result = {}
            local error = vim.lsp.diagnostic.get_count(0, [[Error]])
            local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
            local info = vim.lsp.diagnostic.get_count(0, [[Information]])
            local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])

            if error ~= 0 then
            result[1] = {text = "  " .. error, guifg = "#EC5241"}
            end

            if warning ~= 0 then
            result[2] = {text = "  " .. warning, guifg = "#EFB839"}
            end

            if hint ~= 0 then
            result[3] = {text = "  " .. hint, guifg = "#A3BA5E"}
            end

            if info ~= 0 then
            result[4] = {text = "  " .. info, guifg = "#7EA9A7"}
          end
          return result
        end
        }
    }
}
