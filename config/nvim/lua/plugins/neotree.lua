local neotree = require("neo-tree")

neotree.setup({
	sources = { "filesystem" },
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_by_name = {
				".git",
			},
		},
		hijack_netrw_behavior = "open_default",
	},
	close_if_last_window = true,
	use_libuv_file_watcher = true,
	open_files_do_not_replace_types = { "terminal", "neo-tree", "help" },
})
