local neotree = require("neo-tree")

neotree.setup({
    sources = { "filesystem" },
    filesystem = {
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_by_name = {
                ".git",
            },
        },
        hijack_netrw_behavior = "open_default",
    },
    close_if_last_window = true,
    use_libuv_file_watcher = true,
    open_files_do_not_replace_types = { "terminal", "neo-tree", "help" },
    window = {
        width = 35,
    },
})

local win = vim.api.nvim_get_current_win()
vim.cmd("Neotree")
vim.api.nvim_set_current_win(win)
