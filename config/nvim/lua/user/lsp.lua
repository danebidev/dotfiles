local mason = require("mason")

mason.setup({
	ui = { border = "rounded" },
})

local mason_lspconfig = require("mason-lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

mason_lspconfig.setup({
	ensure_installed = { "lua_ls" }
})


mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
		})
	end,
})
