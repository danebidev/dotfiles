local dap = require("dap")
local dapui = require("dapui")

dap.adapters.cppdbg = {
    type = "executable",
    command = "OpenDebugAD7",
    id = "cppdbg",
}

require("dapui").setup({
    layouts = {
        {
            elements = {
                {
                    id = "scopes",
                    size = 0.6,
                },
                {
                    id = "watches",
                    size = 0.2,
                },
                {
                    id = "stacks",
                    size = 0.1,
                },
                {
                    id = "breakpoints",
                    size = 0.1,
                },
            },
            position = "left",
            size = 45,
        },
        {
            elements = {
                {
                    id = "console",
                    size = 1,
                },
            },
            position = "bottom",
            size = 13,
        },
    },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    vim.cmd("Neotree close")
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({ layout = 1 })
    vim.cmd("Neotree reveal")
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({ layout = 1 })
    vim.cmd("Neotree reveal")
end
