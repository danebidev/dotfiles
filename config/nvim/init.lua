-- ░▀█▀░█▀█░▀█▀░▀█▀░░░░█░░░█░█░█▀█
-- ░░█░░█░█░░█░░░█░░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░░▀▀▀░▀▀▀░▀░▀

-- Early setup {{{
-- leader key
vim.g.mapleader = " "
-- }}}

-- lazy.nvim {{{
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

require("lazy").setup("plugins")
-- }}}

-- User config {{{
local config = {
    -- Core
    "config/options",
    "config/autocmds",

    -- Plugins initialization
    "plugins/util",
    "plugins/ui",
    "plugins/editor",

    -- Plugins configuration
    "config/plugins/editor",
}

for _, v in pairs(config) do
    require(v)
end
-- }}}
