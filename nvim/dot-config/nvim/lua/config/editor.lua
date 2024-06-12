-- Keybinds {{{
local wk = require("which-key")

wk.setup({
    icons = {
        separator = "",
    },
    window = {
        winblend = 5,
    },
})

-- No prefix
wk.register({}, {})

-- <leader> prefix
wk.register({
    h = { "<cmd>wincmd h<CR>", "move left" },
    j = { "<cmd>wincmd j<CR>", "move down" },
    k = { "<cmd>wincmd k<CR>", "move up" },
    l = { "<cmd>wincmd l<CR>", "move right" },

    y = { '"+y', "copy" },
    p = { '"+p', "paste" },

    t = { "<cmd>Neotree<cr>", "open neotree" },
}, { prefix = "<leader>" })
-- }}}

-- NeoTree {{{
require("neo-tree").setup({
    renderers = {
        directory = {
            { "indent" },
            { "icon" },
            {
                "container",
                content = {
                    { "name", zindex = 10 },
                    {
                        "symlink_target",
                        zindex = 10,
                        highlight = "NeoTreeSymbolicLinkTarget",
                    },
                    { "diagnostics", zindex = 20, align = "right", hide_when_expanded = true },
                    { "git_status", zindex = 10, align = "right", hide_when_expanded = true },
                    -- This is useless but without it, the size header is not shown
                    { "file_size", zindex = 10, align = "right" },
                    { "last_modified", zindex = 10, align = "right" },
                },
            },
        },
        file = {
            { "indent" },
            { "icon" },
            {
                "container",
                content = {
                    { "name", zindex = 10 },
                    {
                        "symlink_target",
                        zindex = 10,
                        highlight = "NeoTreeSymbolicLinkTarget",
                    },
                    { "diagnostics", zindex = 20, align = "right", hide_when_expanded = true },
                    { "git_status", zindex = 10, align = "right", hide_when_expanded = true },
                    { "file_size", zindex = 10, align = "right" },
                    { "last_modified", zindex = 10, align = "right" },
                },
            },
        },
    },
    default_component_configs = {
        indent = {
            indent_size = 2,
            with_markers = true,
        },
        modified = {
            symbol = "",
        },
    },
    window = {
        position = "float",
        popup = {
            size = {
                width = "50%",
                height = "80%",
            },
        },
    },
    filesystem = {
        filtered_items = {
            visible = true,
        },
        async_directoty_scan = "always",
        scan_mode = "deep",
    },
    sources = {
        "filesystem",
    },
    enable_opened_markers = false,
    popup_border_style = "double",
    sort_case_insensitive = true,
})
-- }}}

-- Telescope {{{
require("telescope").setup({
    defaults = {
        layout_config = {
            horizontal = {
                height = 0.8,
                width = 0.8,
                preview_width = 0.6,
            },
        },
        winblend = 5,
        selection_caret = " > ",
        initial_mode = "insert",
        path_display = { "smart" },
    },
})
-- }}}
