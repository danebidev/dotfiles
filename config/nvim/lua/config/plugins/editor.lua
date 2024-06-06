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
    sources = {
        "filesystem",
        "git_status",
    },
})
-- }}}
