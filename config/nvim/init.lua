-- Changing leader key to <space>

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugins

require("lazy").setup({
	{ -- Colorscheme
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night",
			})
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	{ -- LSP
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "folke/neodev.nvim", opts = {} },
			{ "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
		},
	},

	{ -- Completion
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"chrisgrieser/cmp-nerdfont",
			"hrsh7th/cmp-emoji",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
	},

	{ -- Telescope
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"natecraddock/telescope-zf-native.nvim",
		},
	},

	{ -- Treesitter
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"windwp/nvim-ts-autotag",
			"windwp/nvim-autopairs",
		},
	},

	-- Some small plugins
	{
		"andweeb/presence.nvim",
		opts = {
			buttons = false,
		},
	},
	{
		"brenoprata10/nvim-highlight-colors",
		opts = {
			enable_named_colors = true,
		},
	},
	"numToStr/Comment.nvim",
	"lervag/vimtex",
	"rhysd/clever-f.vim",
}, {
	ui = {
		size = { width = 0.6, height = 0.8 },
		border = "rounded",
		title = "  lazy.nvim  ",
	},
})

for _, v in pairs({ "settings", "keymaps", "autocmds", "cmp", "telescope", "treesitter", "lsp" }) do
	require("user." .. v)
end
