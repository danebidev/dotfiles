-- Smaller plugins
return {
    -- Fuzzy finder {{{
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            defaults = {
                layout_config = {
                    horizontal = {
                        height = 0.8,
                        width = 0.8,
                        preview_width = 0.6,
                    },
                },
                winblend = 5,
                selection_caret = " > ",
                initial_mode = "insert",
                path_display = { "smart" },
            },
        },
    },
    -- }}}

    -- Commenting {{{
    {
        "numToStr/Comment.nvim",
        event = "BufRead",
    },
    -- }}}
}
