-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

local disable_copilot = vim.api.nvim_create_augroup("DisableCopilot", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        if vim.startswith(vim.fn.expand("%:p:h"), vim.fn.expand("~/programming/cp")) then
            vim.cmd("Copilot disable")
        end
    end,
    group = disable_copilot,
    pattern = "*",
})
