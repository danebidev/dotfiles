return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")

            wk.setup({
                icons = {
                    separator = "",
                },
                window = {
                    winblend = 5,
                },
            })

            vim.keymap.set("i", "<C-l>", 'copilot#Accept("")', {
                expr = true,
                replace_keycodes = false,
            })

            -- No prefix
            wk.register({}, {})

            -- <leader> prefix
            wk.register({
                h = { "<cmd>wincmd h<CR>", "move left" },
                j = { "<cmd>wincmd j<CR>", "move down" },
                k = { "<cmd>wincmd k<CR>", "move up" },
                l = { "<cmd>wincmd l<CR>", "move right" },

                y = { '"+y', "copy" },
                p = { '"+p', "paste" },

                t = { "<cmd>Neotree<cr>", "open neotree" },
            }, { prefix = "<leader>" })
        end,
    },
}
