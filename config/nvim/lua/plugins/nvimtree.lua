vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local nvimtree = require("nvim-tree")

local function on_attach(buff)
	local api = require("nvim-tree.api")

	local nmap = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = buff, desc = "nvim-tree" .. desc, noremap = true, silent = true })
	end

	nmap("<CR>", api.node.open.edit, "Open")
	nmap("o", api.node.open.edit, "Open")
	nmap("<Right>", api.node.open.edit, "Open")
	nmap("zz", api.tree.change_root_to_node, "CD")
	nmap("<Up>", api.node.navigate.sibling.prev, "Previous Sibling")
	nmap("<Down>", api.node.navigate.sibling.next, "Next Sibling")
	nmap("<Left>", api.node.navigate.parent, "Parent Directory")
	nmap("<C-v>", api.node.open.vertical, "Open: Vertical Split")
	nmap("<C-h>", api.node.open.horizontal, "Open: Horizontal Split")
	nmap("<C-t>", api.node.open.tab, "Open: New Tab")
	nmap("zc", api.node.navigate.parent_close, "Close Directory")
	nmap("I", api.tree.toggle_gitignore_filter, "Toggle Git Ignore")
	nmap(".", api.tree.toggle_hidden_filter, "Toggle Dotfiles")
	nmap("n", api.fs.create, "Create")
	nmap("d", api.fs.trash, "Trash")
	nmap("X", api.fs.remove, "Delete")
	nmap("r", api.fs.rename, "Rename")
	nmap("<C-r>", api.fs.rename_sub, "Rename: Omit Filename")
	nmap("R", api.tree.reload, "Refresh")
	nmap("<C-x>", api.fs.cut, "Cut")
	nmap("yy", api.fs.copy.node, "Copy")
	nmap("p", api.fs.paste, "Paste")
	nmap("yp", api.fs.copy.relative_path, "Copy Relative Path")
	nmap("yP", api.fs.copy.absolute_path, "Copy Absolute Path")
	nmap("[", api.node.navigate.git.prev, "Prev Git")
	nmap("]", api.node.navigate.git.next, "Next Git")
	nmap("O", api.node.run.system, "Run System")
	nmap("q", api.tree.close, "Close")
	nmap("<Esc>", api.tree.close, "Close")
	nmap("?", api.tree.toggle_help, "Help")
	nmap("zm", api.tree.collapse_all, "Collapse")
	nmap("zr", api.tree.expand_all, "Expand All")
	nmap("S", api.tree.search_node, "Search")
	nmap("<C-k>", api.node.show_info_popup, "Info")
end

nvimtree.setup({
	on_attach = on_attach,
	disable_netrw = true,
	hijack_cursor = true,
	update_focused_file = { enable = true },
	diagnostics = { enable = true },
	modified = { enable = true },
	remove_keymaps = true,
	view = { signcolumn = "yes" },
	renderer = {
		highlight_git = true,
		root_folder_label = ":t",
		icons = {
			glyphs = {
				git = {
					renamed = "",
					untracked = "◌",
					ignored = "",
				},
			},
		},
	},
	filters = { git_ignored = false },
	actions = {
		expand_all = { exclude = { ".git" } },
	},
})
