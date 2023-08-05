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
				vim.cmd.colorscheme("tokyonight")
			end
		},

		{ -- LSP
			"neovim/nvim-lspconfig",
			dependencies = {
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				{ "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
				{ "folke/neodev.nvim",               opts = {} }
			}
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
				"onsails/lspkind.nvim"
			}
		},

		{ -- Telescope
			"nvim-telescope/telescope.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"natecraddock/telescope-zf-native.nvim"
			}
		},

		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			dependencies = {
				"nvim-treesitter/playground",
				"windwp/nvim-ts-autotag",
				"windwp/nvim-autopairs"
			}
		},

		-- Some small plugins
		{
			"brenoprata10/nvim-highlight-colors",
			opts = {
				enable_named_colors = true
			}
		},
		{
			"lervag/vimtex",
			lazy = false
		},
		"andweeb/presence.nvim",
		"rhysd/clever-f.vim",
	},
	{
		ui = { border = "rounded" }
	})

for _, v in pairs({ "settings", "keymaps", "autocmds", "cmp", "telescope", "treesitter", "lsp", "misc" }) do
	require("user." .. v)
end
