return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "L3MON4D3/cmp-luasnip-choice",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()
            luasnip.config.setup({})

            cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

            cmp.setup({
                enabled = function()
                    local context = require("cmp.config.context")
                    return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                end,
                mapping = {
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        -- elseif luasnip.locally_jumpable(1) then
                        --     luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        -- elseif luasnip.locally_jumpable(-1) then
                        --     luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<CR>"] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
                    }),
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    keyword_length = 1,
                    completeopt = "menu,menuone,noselect",
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
                sorting = {
                    priority_weight = 1.0,
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.kind,
                        cmp.config.compare.scopes,
                        cmp.config.compare.length,
                    },
                },
                sources = {
                    { name = "lazydev", group_index = 1 },
                    { name = "nvim_lsp", group_index = 1 },
                    { name = "luasnip_choice", group_index = 1 },
                    { name = "path", group_index = 2 },
                    { name = "buffer", group_index = 2 },
                },
                performance = { max_view_entries = 15 },
            })
        end,
    },
    {
        "onsails/lspkind.nvim",
    },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
    },
}
