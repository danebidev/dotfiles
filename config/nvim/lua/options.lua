local options = {
    timeout = true,
    timeoutlen = 300,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
