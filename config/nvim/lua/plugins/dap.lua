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

require("cmake-tools").setup({
    cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1", "-DCMAKE_C_COMPILER=clang", "-DCMAKE_CXX_COMPILER=clang++" },
    cmake_build_directory = "build",
    cmake_dap_configuration = {
        type = "cppdbg",
        MIMode = "gdb",
        miDebuggerPath = "/usr/bin/gdb",
        externalConsole = false,
        stopAtEntry = true,
        setupCommands = {
            {
                text = "-enable-pretty-printing",
                description = "enable pretty printing",
                ignoreFailures = false,
            },
        },
    },
    cmake_terminal = {
        opts = {
            split_size = 15,
        },
    },
})

dap.configurations.cpp = {
    {
        name = "Debug current file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return "./build/" .. vim.fn.expand("%:t:r")
        end,
        args = function()
            return vim.split(vim.fn.input("Arguments (cwd is nvim workspace directory): "), " ")
        end,
        MIMode = "gdb",
        miDebuggerPath = "/usr/bin/gdb",
        cwd = "${workspaceFolder}",
        externalConsole = false,
        stopAtEntry = true,
        setupCommands = {
            {
                text = "-enable-pretty-printing",
                description = "enable pretty printing",
                ignoreFailures = false,
            },
        },
    },
}

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
