local lualine = require("lualine")

local mode = {
	"mode",
	fmt = function(str)
		return " " .. str
	end,
}

local filename = {
	"filename",
}

local progress = {
	"progress",
	fmt = function(str)
		if str == "Top" then
			return " 0%%"
		end
		if str == "Bot" then
			return "100%%"
		end
		return str
	end,
}

lualine.setup({
	options = {
		theme = "auto",
		section_separators = { left = "", right = "" },
		component_separators = "",
		refresh = { statusline = 300 },
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { "branch", "diff" },
		lualine_c = { filename, "diagnostics" },
		lualine_x = { lsp_progress },
		lualine_y = { "filetype", "encoding" },
		lualine_z = { progress },
	},
})
