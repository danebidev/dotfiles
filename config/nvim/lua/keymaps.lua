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

-- Bufferline
map("n", "<leader>>", "<Cmd>BufferLineCycleNext<CR>", "[>] Next buffer")
map("n", "<leader><", "<Cmd>BufferLineCyclePrev<CR>", "[<] Previous buffer")
map("n", "<leader>cb", function()
    require("bufdelete").bufdelete(0)
end, "[C]lose current [b]uffer")

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
    vim.cmd("Neotree close")
    require("dap").run(require("dap").configurations.cpp[1])
end, "[C]++: Build current [f]ile and [d]ebug it")
map("n", "<leader>cpd", function()
    vim.cmd("Neotree close")
    vim.cmd("CMakeDebug")
end, "[C]++: Build [p]roject and [d]ebug")
map("n", "<leader>cpr", "<Cmd>CMakeRun<CR>", "[C]++: Build current [p]roject and [r]un it")
map("n", "<leader>cla", require("cmake-tools").launch_args, "[C]++: Set [l]aunch [a]rgs")

-- DAP
map("n", "<leader>bt", require("dap").toggle_breakpoint, "[B]reakpoint [t]oggle ")
