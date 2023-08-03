local telescope = require("telescope")

telescope.load_extension("zf-native")

telescope.setup({

	defaults = {
		layout_strategy = "vertical",
		layout_config = {
			vertical = {
				prompt_position = "top",
			},
		},
		sorting_strategy = "ascending",
		prompt_prefix = " 󰭎  ",
		selection_caret = "  ",
		path_display = { "smart" }
	}
})
