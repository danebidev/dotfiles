local lualine = require("lualine")

lualine.setup({
	options = {
		theme = "auto",
		section_separators = "",
		component_separators = "",
		ignore_focus = { "TelescopePrompt", "NvimTree", "lazy", "mason"},
		globalstatus = true,
		refresh = { statusline = 300 }
	},
	sections = {
		lualine_c = {
			"lsp_progress",
		},
	},
})
