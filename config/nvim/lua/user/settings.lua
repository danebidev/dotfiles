local options = {

	----------------------------- Indentation ----------------------------
	tabstop = 4,
	shiftwidth = 4,
	autoindent = true,
	smartindent = true,
	----------------------------------------------------------------------

	------------------------- Movement and search ------------------------
	wrapscan = true,
	incsearch = true,
	ignorecase = true,
	scrolloff = 50,
	sidescrolloff = 5,
	----------------------------------------------------------------------

	-------------------------------- Text --------------------------------
	wrap = false,
	linebreak = true,
	breakindent = true,
	formatoptions = "nqc1jp",
	spell = false,
	----------------------------------------------------------------------

	--------------------------------- UI ---------------------------------
	shortmess = "filnxtToOFcsS",
	number = true,
	relativenumber = true,
	termguicolors = true,
	signcolumn = "yes",
	foldmethod = "marker",
	showmode = false,
	completeopt = { "menu", "menuone", "noselect" },
	----------------------------------------------------------------------

	------------------------------- Extra --------------------------------
	mouse = "nv",
	splitbelow = true,
	splitright = true,
	swapfile = false,
	undofile = true,
	timeout = true,
	timeoutlen = 750,
	----------------------------------------------------------------------
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
