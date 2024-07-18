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
                win = {
                    winblend = 5,
                },
            })

            vim.keymap.set("i", "<C-l>", 'copilot#Accept("")', {
                expr = true,
                replace_keycodes = false,
            })

            vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

            -- <leader> prefix
            wk.add({
                -- Splits movement
                { "<leader>h",        "<cmd>wincmd h<CR>",                               desc = "move left" },
                { "<leader>j",        "<cmd>wincmd j<CR>",                               desc = "move down" },
                { "<leader>k",        "<cmd>wincmd k<CR>",                               desc = "move up" },
                { "<leader>l",        "<cmd>wincmd l<CR>",                               desc = "move right" },

                -- System clipboard
                { "<leader>y",        '"+y',                                             desc = "system copy" },
                { "<leader>p",        '"+p',                                             desc = "system paste" },

                -- Neotree
                { "<leader>t",        "<cmd>Neotree<cr>",                                desc = "open neotree" },

                -- Telescope
                { "<leader><leader>", "<cmd>Telescope buffers<cr>",                      desc = "buffers" },
                { "<leader>/",        "<cmd>Telescope current_buffer_fuzzy_find<cr>",    desc = "current buffer" },

                -- Search
                { "<leader>s",        group = "search" },
                { "<leader>sf",       "<cmd>Telescope find_files<cr>",                   desc = "find files" },
                { "<leader>sg",       "<cmd>Telescope live_grep<cr>",                    desc = "live grep" },
                { "<leader>sh",       "<cmd>Telescope help_tags<cr>",                    desc = "help tags" },

                { "<leader>d",        group = "debug" },
                { "<leader>db",       "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "toggle breakpoint" },
                { "<leader>dr",       "<cmd>lua require('dap').toggle_repl()<cr>",       desc = "toggle repl" },
                { "<leader>dc",       "<cmd>lua require('dap').continue()<cr>",          desc = "continue" },
                { "<leader>di",       "<cmd>lua require('dap').step_into()<cr>",         desc = "step into" },
                { "<leader>do",       "<cmd>lua require('dap').step_over()<cr>",         desc = "step over" },
                { "<leader>dt",       "<cmd>lua require('dap').stop()<cr>",              desc = "terminate" },
            })
        end,
    },
}
