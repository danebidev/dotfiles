local wk = require("which-key")
local dap = require("dap")
local cpp = require("plugins.cpp")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- No <leader> prefix
wk.register({})

-- <leader> prefix
wk.register({
    -- Move between splits
    h = { "<cmd>wincmd h<CR>", "move left" },
    j = { "<cmd>wincmd j<CR>", "move down" },
    k = { "<cmd>wincmd k<CR>", "move up" },
    l = { "<cmd>wincmd l<CR>", "move right" },

    -- System clipboard
    y = { '"+y', "copy" },
    Y = { '"+y$', "copy line" },
    p = { '"+p', "paste after cursor" },
    P = { '"+P', "paste before cursor" },

    t = { "<cmd>Neotree float<cr>", "open tree" },

    -- Open
    o = {
        name = "open",
    },

    -- Search / Find
    s = {
        name = "search",
    },

    q = {
        name = "quit",
        w = { "<cmd>q<CR>", "window" },
        W = { "<cmd>wincmd o<CR>", "window" },
        b = { "<cmd>Bdelete<CR>", "buffer" },
        B = { "<cmd>BufOnly<CR>", "all other buffers" },
    },

    -- Debug
    d = {
        name = "debug",
        b = { dap.toggle_breakpoint, "toggle breakpoint" },
        c = { dap.continue, "continue" },
        t = {
            function()
                dap.terminate()
                require("dapui").close({ layout = 1 })
            end,
            "terminate",
        },
        s = { dap.step_over, "step over" },
        i = { dap.step_into, "step into" },
        o = { dap.step_out, "step out" },
    },

    -- C++ / CMake
    c = {
        name = "cpp",
        l = {
            function()
                return "<Cmd>CMakeLaunchArgs " .. vim.fn.input("Arguments (cwd is build directory): ")
            end,
            "set launch arguments",
        },
        F = { cpp.debug_file, "debug file" },
        P = { cpp.debug_project, "debug CMake project" },
    },
}, { prefix = "<leader>" })
