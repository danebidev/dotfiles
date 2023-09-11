local wk = require("which-key")
local dap = require("dap")
local cpp = require("plugins.cpp")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- No <leader> prefix
wk.register({})

-- <leader> prefix
wk.register({
    -- Move between splits
    h = { "<cmd>wincmd h<CR>", "Move left" },
    j = { "<cmd>wincmd j<CR>", "Move down" },
    k = { "<cmd>wincmd k<CR>", "Move up" },
    l = { "<cmd>wincmd l<CR>", "Move right" },

    -- System clipboard
    y = { '"+y', "Copy" },
    Y = { '"+y$', "Copy line" },
    p = { '"+p', "Paste after cursor" },
    P = { '"+P', "Paste before cursor" },

    -- Debug
    d = {
        name = "debug",
        b = { dap.toggle_breakpoint, "Toggle breakpoint" },
        c = { dap.continue, "Continue" },
        t = {
            function()
                dap.terminate()
                require("dapui").close({ layout = 1 })
            end,
            "Terminate",
        },
        s = { dap.step_over, "Step over" },
        i = { dap.step_into, "Step into" },
        o = { dap.step_out, "Step out" },
    },

    -- C++ / CMake
    c = {
        name = "c++",
        l = {
            function()
                return "<Cmd>CMakeLaunchArgs " .. vim.fn.input("Arguments (cwd is build directory): ")
            end,
            "Set launch arguments",
        },
        f = { cpp.build_file, "Build file" },
        F = { cpp.debug_file, "Debug file" },
        p = { cpp.build_project, "Run project (CMake)" },
        P = { cpp.debug_project, "Debug project (CMake)" },
    },
}, { prefix = "<leader>" })
