return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
        },
        format_on_save = { timeout_ms = 100, lsp_format = "fallback" },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
