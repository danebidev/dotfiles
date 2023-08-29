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

local fileformat = {
	"fileformat",
	padding = { left = 1, right = 2 },
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
		section_separators = { left = "", right = "" },
		component_separators = "",
		refresh = { statusline = 100 },
		disabled_filetypes = {
			statusline = { "TelescopePrompt", "neo-tree", "Mason", "lazy" },
		},
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { "branch", "diff" },
		lualine_c = { "filetype", filename, diagnostics },
		lualine_x = { lsp_progress },
		lualine_y = { "encoding", fileformat },
		lualine_z = { progress },
	},
})
