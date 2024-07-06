return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            dap.adapters.lldb = {
                type = "executable",
                command = "/usr/bin/lldb-vscode",
                name = "lldb",
            }

            dap.configurations.cpp = {
                {
                    name = "cpp_launch",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = true,
                    args = function()
                        return vim.fn.input("Arguments: ", "", "command")
                    end,
                    runInTerminal = false,
                },
            }

            dap.configurations.c = dap.configurations.cpp
        end
    }
}
