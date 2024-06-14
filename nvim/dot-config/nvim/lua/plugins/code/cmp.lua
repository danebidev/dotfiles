return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
            "L3MON4D3/LuaSnip",
            "L3MON4D3/cmp-luasnip-choice",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()
            luasnip.config.setup({})

            cmp.setup({
                enabled = function()
                    local context = require("cmp.config.context")
                    return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                end,
                preselect = cmp.PreselectMode.None,
                mapping = {},
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    keyword_length = 1,
                },
                formatting = {
                    format = require("lspkind").cmp_format({
                        mode = "symbol", -- Can be 'text', 'symbol_text', 'text_symbol' or 'symbol'
                        maxwidth = function()
                            return math.floor(0.35 * vim.o.columns)
                        end,
                        ellipsis_char = "...",
                        show_labelDetails = true, -- This does something. I don't know what
                        -- Called before lspkind
                        -- before = function(entry, vim_item)
                        --     return vim_item
                        -- end,
                    }),
                },
                matching = {
                    disallow_fuzzy_matching = false,
                },
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.scope,
                        cmp.config.compare.locality,
                        cmp.config.compare.kind,
                        cmp.config.compare.length,
                    },
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "cmdline" },
                    { name = "emoji" },
                },
            })
        end,
    },
    {
        "onsails/lspkind.nvim",
    },
    {
        "L3MON4D3/LuaSnip",
    },
}
