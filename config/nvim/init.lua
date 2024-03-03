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
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "Hoffs/omnisharp-extended-lsp.nvim",
            "lervag/vimtex",
            { "folke/neodev.nvim", opts = {} },
            { "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
        },
    },
    -- }}}

    -- DAP {{{
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "Civitasv/cmake-tools.nvim",
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
            {
                "zbirenbaum/copilot.lua",
                cmd = "Copilot",
                event = "InsertEnter",
                dependencies = {
                    "zbirenbaum/copilot-cmp",
                    "gptlang/CopilotChat.nvim",
                },
            },
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

    -- neo-tree {{{
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    },
    -- }}}

    -- Lualine {{{
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            { "nvim-tree/nvim-web-devicons", opts = {} },
            { "linrongbin16/lsp-progress.nvim", opts = {} },
        },
    },
    -- }}}

    -- Smaller plugins {{{
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
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 1000
        end,
        opts = {},
    },
    {
        "akinsho/toggleterm.nvim",
        opts = {
            open_mapping = "<leader><cr>",
            insert_mappings = false,
            start_in_insert = false,
            terminal_mappings = false,
        },
    },
    {
        "andweeb/presence.nvim",
        opts = {
            buttons = false,
        },
    },
    { "xeluxee/competitest.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
    { "numToStr/Comment.nvim", opts = {} },
    { "folke/trouble.nvim", opts = {} },
    "famiu/bufdelete.nvim",
    "numtostr/BufOnly.nvim",
    "rhysd/clever-f.vim",
    "rcarriga/nvim-notify",
    "turbio/bracey.vim",
    -- }}}
}, {
    -- Lazy config
    ui = {
        size = { width = 0.6, height = 0.8 },
        border = "rounded",
        title = "  lazy.nvim  ",
    },
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
    "plugins.lualine",
    "plugins.lsp",
    "plugins.dap",
    "plugins.cpp",
    "plugins.autopairs",
    "plugins.cmp",
    "plugins.neotree",
    "plugins.competitest",
}

for _, v in pairs(config) do
    require(v)
end
-- }}}
