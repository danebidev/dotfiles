-- WhichKey {{{
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
wk.register({}, { prefix = "<leader>" })
-- }}}

-- NeoTree {{{
require("neo-tree").setup({
    window = {
        position = "float",
        popup = {
            size = {
                width = "50%",
                height = "80%",
            },
        },
    },
    default_component_configs = {},
    sources = {
        "filesystem",
    },
    enable_opened_markers = false,
    popup_border_style = "double",
    sort_case_insensitive = true,
})
-- }}}
