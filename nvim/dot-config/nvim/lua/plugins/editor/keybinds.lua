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

            vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

            -- <leader> prefix
            wk.register({
                -- Splits movement
                h = { "<cmd>wincmd h<CR>", "move left" },
                j = { "<cmd>wincmd j<CR>", "move down" },
                k = { "<cmd>wincmd k<CR>", "move up" },
                l = { "<cmd>wincmd l<CR>", "move right" },

                -- System clipboard
                y = { '"+y', "copy" },
                p = { '"+p', "paste" },

                -- Neotree
                t = { "<cmd>Neotree<cr>", "open neotree" },

                -- Telescope
                ["<leader>"] = { "<cmd>Telescope buffers<cr>", "buffers" },
                ["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "current buffer" },

                s = {
                    name = "search",
                    f = { "<cmd>Telescope find_files<cr>", "find files" },
                    g = { "<cmd>Telescope live_grep<cr>", "live grep" },
                    h = { "<cmd>Telescope help_tags<cr>", "help tags" },
                }
            }, { prefix = "<leader>" })
        end,
    },
}
