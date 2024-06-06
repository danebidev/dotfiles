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
}
