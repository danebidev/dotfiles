local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
    ensure_installed = {
        "lua",
        "c",
        "cpp",
        "python",
        "cmake",
        "html",
        "javascript",
        "json",
        "html",
    },
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-s>",
            node_decremental = "<M-space>",
        },
    },
    textobjects = {
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["gj"] = "@function.outer",
                ["]]"] = "@class.outer",
                ["]b"] = "@block.outer",
                ["]a"] = "@parameter.inner",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["gJ"] = "@function.outer",
                ["]["] = "@class.outer",
                ["]B"] = "@block.outer",
                ["]A"] = "@parameter.inner",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["gk"] = "@function.outer",
                ["[["] = "@class.outer",
                ["[b"] = "@block.outer",
                ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["gK"] = "@function.outer",
                ["[]"] = "@class.outer",
                ["[B"] = "@block.outer",
                ["[A"] = "@parameter.inner",
            },
        },
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["a/"] = "@comment.outer",
                ["i/"] = "@comment.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
            },
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
        autopairs = { enable = true },
        autotag = { enable = true },
    },
})
