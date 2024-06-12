-- Options {{{
local options = {
    autoindent = true,
    tabstop = 4,
    expandtab = true,
    shiftwidth = 4,
    smartindent = true,
    softtabstop = 0,

    ignorecase = true,
    scrolloff = 10,
    sidescrolloff = 10,

    wrap = false,
    spell = false,
    formatoptions = "nqc1jp",

    shortmess = "filnxtToOFcsS",
    number = true,
    relativenumber = true,
    termguicolors = true,
    signcolumn = "yes",
    foldmethod = "marker",
    showmode = false,
    completeopt = { "menuone", "noselect" },

    mouse = "a",
    splitbelow = true,
    splitright = true,
    swapfile = false,
    undofile = true,

    timeout = true,
    timeoutlen = 350,
}
-- }}}

for k, v in pairs(options) do
    vim.opt[k] = v
end
