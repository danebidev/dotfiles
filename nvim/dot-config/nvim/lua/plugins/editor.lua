return {
    -- Keybinds
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
    },
    -- }}}

    -- File explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    },
    -- }}}

    -- Fuzzy finder {{{
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-tree/nvim-web-devicons",
        },
    },
    -- }}}

    -- Commenting {{{
    {
        "numToStr/Comment.nvim",
        event = "BufRead",
    },
}
