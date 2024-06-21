return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")

            npairs.setup({
                enable_check_bracket_line = false,
                ignored_next_char = "[%w]",
                check_ts = true,
                fast_wrap = {
                    map = "<M-e>",
                    chars = { "{", "[", "(", '"', "'" },
                    pattern = [=[[%'%"%>%]%)%}%,]]=],
                    end_key = "$",
                    before_key = "h",
                    after_key = "l",
                    cursor_pos_before = false,
                    keys = "qwertyuiopzxcvbnmasdfghjkl",
                    manual_position = true,
                    highlight = "Search",
                    highlight_grey = "Comment",
                },
            })
        end,
    },
}
