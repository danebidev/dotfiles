-- Change leader key to <space>

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim {{{

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
-- }}}

-- Plugins

require("lazy").setup({
	-- Colorscheme {{{
	{
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
	-- }}}

	-- LSP {{{
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "folke/neodev.nvim", opts = {} },
			{ "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
		},
	},
	-- }}}

	-- Completion {{{
	{
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
	-- }}}
	
	-- Telescope {{{
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"natecraddock/telescope-zf-native.nvim",
		},
	},
	-- }}}

	-- Treesitter {{{
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"windwp/nvim-ts-autotag",
			"windwp/nvim-autopairs",
		},
	},
	-- }}}

	-- nvim-tree {{{
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"antosha417/nvim-lsp-file-operations",
		},
	},
	-- }}}

	-- Some small plugins {{{
	{
		"anuvyklack/pretty-fold.nvim",
		opts = {
			sections = {
				left = { "content", "⮯ " },
				right = { " ", "number_of_folded_lines", ": ", "percentage" },
			},
			fill_char = "⋅",
			process_comment_signs = "delete",
		},
	},
	{
		"anuvyklack/fold-preview.nvim",
		opts = {
			auto = 500,
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
		dependencies = { "anuvyklack/keymap-amend.nvim" },
	},
	{
		"andweeb/presence.nvim",
		opts = {
			buttons = false,
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 1000
		end,
		opts = {},
	},
	{
		"brenoprata10/nvim-highlight-colors",
		opts = {
			enable_named_colors = false,
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"lervag/vimtex",
		lazy = false,
	},
	"rhysd/clever-f.vim",
	-- }}}
}, {
	-- Lazy config {{{
	ui = {
		size = { width = 0.6, height = 0.8 },
		border = "rounded",
		title = "  lazy.nvim  ",
	},
	-- }}}
})

-- User config {{{
local config = {
	-- Core
	"options",
	"keymaps",
	"autocmds",

	-- Plugins
	"plugins.telescope",
	"plugins.treesitter",
	"plugins.lsp",
	"plugins.autopairs",
	"plugins.cmp",
	"plugins.nvimtree",
}

for _, v in pairs(config) do
	require(v)
end
-- }}}
