vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ timeout = 200, higroup = "Visual" })
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', 'goto declaration')
        map('gd', '<cmd>lua vim.lsp.buf.definition()<CR>', 'goto definition')
        map('K', '<cmd>lua vim.lsp.buf.hover()<CR>', 'show hover')
        map('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', 'goto implementation')
        map('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'show signature help')

        map('<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', 'code action')
        map('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', 'rename')
    end
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = '*.c',
    callback = function()
        vim.bo.filetype = 'c'
    end
})

local group_cdpwd = vim.api.nvim_create_augroup("group_cdpwd", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
    group = group_cdpwd,
    pattern = "*",
    callback = function()
        vim.api.nvim_set_current_dir(vim.fn.expand("%:p:h"))
    end,
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
