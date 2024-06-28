vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ timeout = 200, higroup = "Visual" })
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format()
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
    end
})
