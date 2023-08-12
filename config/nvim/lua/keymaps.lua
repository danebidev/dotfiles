-- Helper function
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Disable arrow keys
map("", "<Up>", "<Nop>")
map("", "<Down>", "<Nop>")
map("", "<Left>", "<Nop>")
map("", "<Right>", "<Nop>")

-- System clipboard copy and paste
map("n", "<leader>y", '"+y')
map("n", "<leader>Y", '"+y$')

map("n", "<leader>p", '"+p')
map("n", "<leader>P", '"+P')
