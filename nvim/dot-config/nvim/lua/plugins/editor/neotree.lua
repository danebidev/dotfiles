return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            renderers = {
                directory = {
                    { "indent" },
                    { "icon" },
                    {
                        "container",
                        content = {
                            { "name",          zindex = 10 },
                            {
                                "symlink_target",
                                zindex = 10,
                                highlight = "NeoTreeSymbolicLinkTarget",
                            },
                            { "diagnostics",   zindex = 20, align = "right", hide_when_expanded = true },
                            { "git_status",    zindex = 10, align = "right", hide_when_expanded = true },
                            -- This is useless but without it, the size header is not shown
                            { "file_size",     zindex = 10, align = "right" },
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
                            { "name",          zindex = 10 },
                            {
                                "symlink_target",
                                zindex = 10,
                                highlight = "NeoTreeSymbolicLinkTarget",
                            },
                            { "diagnostics",   zindex = 20, align = "right", hide_when_expanded = true },
                            { "git_status",    zindex = 10, align = "right", hide_when_expanded = true },
                            { "file_size",     zindex = 10, align = "right" },
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
            popup_border_style = "single",
            sort_case_insensitive = true,
        },
    },
}
