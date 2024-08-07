return {
    {
        "neanias/everforest-nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("everforest").setup({
                background = "medium",
                colours_override = function(palette)
                    palette.bg0 = "#232A2E"
                end
            })
            require("everforest").load()
        end,
    }
}
