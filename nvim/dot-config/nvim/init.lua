-- ░▀█▀░█▀█░▀█▀░▀█▀░░░░█░░░█░█░█▀█
-- ░░█░░█░█░░█░░░█░░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░░▀▀▀░▀▀▀░▀░▀

-- Early setup {{{
-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
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

require("lazy").setup({
    {
        -- { import = "plugins.theme" },
        { import = "plugins.lib" },
        { import = "plugins.editor" },
        { import = "plugins.code" },
    },
})
-- }}}

-- User config {{{
local config = {
    -- Core
    "config/settings",
    "config/autocmds",
}

for _, v in pairs(config) do
    require(v)
end
-- }}}
