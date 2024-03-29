require("mason-tool-installer").setup({
    ensure_installed = {
        "lua-language-server",
        "black",
        "stylua",
        "clang-format",
        "clangd",
        "cmake-language-server",
        "typescript-language-server",
        "cpptools",
        "pyright",
        "omnisharp",
        "html-lsp",
        "eslint-lsp",
        "prettier",
        "json-lsp",
        "rust-analyzer",
        "ruby-lsp",
        "texlab",
        "bash-language-server",
    },
    auto_update = true,
})

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
    vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({
                bufnr = bufnr,
                filter = function(client)
                    return client.name ~= "html"
                end,
            })
        end,
    })
end

local on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>Ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")

    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    if client.supports_method("textDocument/formatting") then
        enable_format_on_save(client, bufnr)
    end
end

local null_ls = require("null-ls")

null_ls.setup({
    border = "rounded",
    sources = {
        -- Formatters
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.eslint,
    },
    on_attach = on_attach,
})

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {
        texthl = sign.name,
        text = sign.text,
        numhl = sign.name,
    })
end

local diagnostic_config = {
    underline = false,
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}

vim.diagnostic.config(diagnostic_config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

local mason = require("mason")

require("neodev").setup()

mason.setup({
    ui = {
        border = "rounded",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
        width = 0.6,
        height = 0.8,
    },
})

local mason_lspconfig = require("mason-lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
    cmake = {},
    pyright = {},
    clangd = {},
    eslint = {},
    texlab = {},
    rust_analyzer = {},
    ruby_ls = {},
    bashls = {},
    jsonls = {},
    tsserver = {},
    omnisharp = {
        handlers = {
            ["textDocument/definition"] = require("omnisharp_extended").handler,
        },
        cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
        enable_editorconfig_support = true,
        enable_ms_build_load_projects_on_demand = false,
        enable_roslyn_analyzers = true,
        analyze_open_documents_only = true,
        organize_imports_on_format = true,
        enable_import_completion = false,
        sdk_include_prereleases = true,
    },
    html = {
        settings = {
            html = {
                format = {
                    enable = false,
                },
            },
        },
    },
    phpactor = {
        root_dir = function(fname)
            local primary = require("lspconfig.util").root_pattern(".git", "compacter.json")(fname)
            local fallback = vim.uv.cwd()
            return primary or fallback
        end,
    },
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = { disable = { "missing-fields" } },
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                format = { enable = false },
            },
        },
    },
}

mason_lspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup(vim.tbl_extend("force", servers[server_name], {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
            end,
        }))
    end,
})
