local lualine = require("lualine")

local mode = {
	"mode",
	fmt = function(str)
		return " " .. str
	end,
}

local filename = {
	"filename",
	newfile_status = true,
	symbols = { modified = "󰏫 ", readonly = "󰏮 " },
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " ", hint = " " },
}

local lsp_progress = {
	"lsp_progress",
	display_components = { "spinner", { "percentage" }, "lsp_client_name" },
	timer = { spinner = 200 },
}

local progress = {
	"progress",
	-- separator = { left = "", right = "" },
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
		section_separators = { left = "", right = "" },
		component_separators = "",
		refresh = { statusline = 100 },
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { "branch", "diff" },
		lualine_c = { "filetype", filename, diagnostics },
		lualine_x = { lsp_progress },
		lualine_y = { "encoding", "fileformat" },
		lualine_z = { progress },
	},
})
