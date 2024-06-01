-- ░▀█▀░█▀█░▀█▀░▀█▀░░░░█░░░█░█░█▀█
-- ░░█░░█░█░░█░░░█░░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░░▀▀▀░▀▀▀░▀░▀

-- Early setup {{{

-- leader key
vim.g.mapleader = " "
-- }}}

-- lazy.nvim bootstrapping {{{

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- lazy.nvim plugins {{{

require("lazy").setup({
    -- WhichKey
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },
}, {})
-- }}}

-- User config {{{

local config = {
    -- Core
    "options",
    "keymaps",
    "autocmds",
}

for _, v in pairs(config) do
    require(v)
end
-- }}}
