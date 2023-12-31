local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local copilot = require("copilot")

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

local compare = cmp.config.compare

cmp.setup({
    enabled = function()
        local context = require("cmp.config.context")
        if vim.api.nvim_get_mode().mode == "c" then
            return true
        else
            return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
        end
    end,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = {
        keyword_length = 1,
    },
    window = {
        completion = {
            scrollbar = false,
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
                else
                    fallback()
                end
            end,
            s = cmp.confirm({ select = true }),
            c = cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",

            before = function(_, vim_item)
                return vim_item
            end,
        }),
    },
    sources = {
        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "path", group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "emoji", group_index = 2 },
        { name = "nerdfont", group_index = 2 },
    },
    sorting = {
        priority_weight = 1.0,
        comparators = {
            require("copilot_cmp.comparators").prioritize,
            compare.locality,
            compare.recently_used,
            compare.score,
            compare.offset,
            compare.order,
        },
    },
    performance = { max_view_entries = 15 },
})

copilot.setup({
    panel = { enabled = false },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
            accept = "<C-l>",
            accept_word = false,
            accept_line = false,
            next = "<C-y>",
            prev = "<C-g>",
            dismiss = "<C-e>",
        },
    },
    filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
    },
    copilot_node_command = "node",
    server_opts_overrides = {},
})
