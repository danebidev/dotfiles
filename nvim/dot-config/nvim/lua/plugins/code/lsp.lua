return {
    {
        "neovim/nvim-lspconfig",
        priority = 50,
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                border = "double",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
                width = 0.6,
                height = 0.8,
            },
        },
        priority = 100,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        opts = {
            ensure_installed = {},
            auto_update = true,
        },
        priority = 150,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            local settings = {}

            require("mason-lspconfig").setup()
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup(vim.tbl_extend("force", settings[server_name] or {}, {}))
                end,
            })
        end,
        priority = 150,
    },
}
