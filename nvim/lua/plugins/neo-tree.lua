require("neo-tree").setup({
    window = {
        mappings = {
            ["P"] = {
                "toggle_preview",
                config = {
                    use_float = false,
                    -- use_image_nvim = true,
                    -- use_snacks_image = true,
                    -- title = 'Neo-tree Preview',
                },
            },
        }
    }
})
