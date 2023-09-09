-- Helper function
local function map(mode, lhs, rhs, desc, opts)
    local options = { noremap = true, silent = true, desc = desc }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Disable some keybinds
map("", "<Up>", "<Nop>")
map("", "<Down>", "<Nop>")
map("", "<Left>", "<Nop>")
map("", "<Right>", "<Nop>")

-- System clipboard copy and paste
map("n", "<leader>y", '"+y', "[Y]ank in system clipboard")
map("n", "<leader>Y", '"+y$', "[Y]ank line in system clipboard")
map("n", "<leader>p", '"+p', "[P]aste from system clipboard after cursor")
map("n", "<leader>P", '"+P', "[P]aste from system clipboard before cursor")

-- Terminal
map("n", "<leader>t", "<Cmd>split | resize 18 | terminal<CR>", "Open [t]erminal in split")
map("t", "<Esc>", "<C-\\><C-n>")

-- C++ / CMake
map("n", "<leader>cfb", function()
    local file = vim.fn.expand("%")
    local bufname = vim.fn.expand("%:t:r")
    vim.cmd("!mkdir -p build && clang++ -std=c++20 -o ./build/" .. bufname .. " " .. file)
end, "[C]++: Current [f]ile [b]uild")
map("n", "<leader>cfd", function()
    local file = vim.fn.expand("%")
    local bufname = vim.fn.expand("%:t:r")
    vim.cmd("!mkdir -p build && clang++ -std=c++20 -g -o ./build/" .. bufname .. " " .. file)
    require("dap").run(require("dap").configurations.cpp[1])
end, "[C]++: Build current [f]ile and [d]ebug it")
map("n", "<leader>cpd", function()
    vim.cmd("CMakeDebug")
end, "[C]++: Build [p]roject and [d]ebug")
map("n", "<leader>cpr", function()
    vim.cmd("CMakeRun")
end, "[C]++: Build current [p]roject and [r]un it")
map("n", "<leader>cl", function()
    local args = vim.fn.input("Arguments (cwd is build directory): ")
    vim.cmd("CMakeLaunchArgs " .. args)
end, "[C]++: Set [l]aunch [a]rgs")

-- DAP
map("n", "<leader>db", require("dap").toggle_breakpoint, "[D]AP: [B]reakpoint [t]oggle ")
map("n", "<leader>dso", require("dap").step_over, "[D]AP: [S]tep [o]ver")
map("n", "<leader>dsi", require("dap").step_into, "[D]AP: [S]tep [i]nto")
map("n", "<leader>dsO", require("dap").step_out, "[D]AP: [S]tep [o]ut")
map("n", "<leader>dc", require("dap").continue, "[D]AP: [C]ontinue")
map("n", "<leader>dt", function()
    require("dap").terminate()
    require("dapui").close({ layout = 1 })
    vim.cmd("Neotree reveal")
end, "[D]AP: [T]erminate")
