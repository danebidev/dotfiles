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
    completeopt = { "menu", "noselect", "menuone" },

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

vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
end, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
end, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

local signs = {
    [vim.diagnostic.severity.ERROR] = "",
    [vim.diagnostic.severity.WARN] = "",
    [vim.diagnostic.severity.INFO] = "",
    [vim.diagnostic.severity.HINT] = "",
}

local signhl = {
    [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
    [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
    [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
}

local diagnostic_config = {
    virtual_text = true,
    update_in_insert = true,
    underline = false,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
    signs = {
        text = signs,
        numhl = signhl,
    },
}

vim.diagnostic.config(diagnostic_config)
