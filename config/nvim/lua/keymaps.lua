-- Helper function
local function map(mode, lhs, rhs, desc, opts)
    local options = { noremap = true, silent = true, desc = desc }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Disable arrow keys
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
map("n", "<leader>>", "<Cmd>BufferLineCycleNext<CR>", "[ ] Next buffer")
map("n", "<leader><", "<Cmd>BufferLineCyclePrev<CR>", "[ ] Previous buffer")
map("n", "<leader>cb", function()
    require("bufdelete").bufdelete(0)
end, "[C]lose current [b]uffer")

-- Terminal
map("n", "<leader>t", "<Cmd>split | resize 18 | terminal<CR>", "Open [t]erminal in split")
map("t", "<Esc>", "<C-\\><C-n>")
