vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local nvimtree = require("nvim-tree")

local function on_attach(buff)
	local api = require("nvim-tree.api")

	local nmap = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = buff, desc = "nvim-tree" .. desc, noremap = true, silent = true })
	end

	nmap("<CR>", api.node.open.edit, "Open")
	nmap("<Right>", api.node.open.edit, "Open")
	nmap("zz", api.tree.change_root_to_node, "Change Directory")
	nmap("<Up>", api.node.navigate.sibling.prev, "Previous Sibling")
	nmap("<Down>", api.node.navigate.sibling.next, "Next Sibling")
	nmap("<Left>", api.node.navigate.parent, "Parent Directory")
end

nvimtree.setup({
	on_attach = on_attach,
	disable_netrw = true,
	hijack_cursor = true,
	update_focused_file = { enable = true },
	diagnostics = { enable = true },
	modified = { enable = true },
	remove_keymaps = true,
	view = {
		number = true,
		relativenumber = true,
		signcolumn = "yes",
		float = {
			enable = true,
		},
	},
})
