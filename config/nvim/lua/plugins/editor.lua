return {
    -- WhichKey {{{
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            icons = {
                separator = "",
            },
            window = {
                winblend = 5,
            },
        },
        config = function()
            local wk = require("which-key")

            -- No prefix
            wk.register({}, {})

            -- <leader> prefix
            wk.register({}, { prefix = "<leader>" })
        end,
    },
    -- }}}
}
