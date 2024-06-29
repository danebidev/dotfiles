return {
    -- Commenting {{{
    {
        "numToStr/Comment.nvim",
        event = "BufRead",
    },
    -- }}}

    -- Terminal {{{
    {
        "akinsho/nvim-toggleterm.lua",
        opts = {
            open_mapping = "<leader><cr>",
            insert_mappings = false,
            start_in_insert = false,
            terminal_mappings = false,
        }
    },
    -- }}}

    -- Discord presence
    {
        "andweeb/presence.nvim",
        opts = {
            buttons = false,
        },
    },

    -- Trouble
    { "folke/trouble.nvim", opts = {} },

    { "rhysd/clever-f.vim" }
}
