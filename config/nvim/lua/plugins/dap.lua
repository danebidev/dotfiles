local dap = require("dap")

require("cmake-tools").setup({
    cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1", "-DCMAKE_C_COMPILER=clang", "-DCMAKE_CXX_COMPILER=clang++" },
    cmake_build_directory = "build",
    cmake_dap_configuration = {
        stopOnEntry = true,
    },
    cmake_terminal = {
        opts = {
            split_size = 15,
        },
    },
})

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}

dap.configurations.cpp = {
    {
        name = "Debug current file",
        type = "codelldb",
        request = "launch",
        program = function()
            return "./build/" .. vim.fn.expand("%:t:r")
        end,
        args = function()
            local input = vim.fn.input("Arguments: ")
            local t = {}
            for str in string.gmatch(input, "([^ ]+)") do
                table.insert(t, str)
            end
            return t
        end,
        cwd = "${workspaceFolder}",
        terminal = "integrated",
    },
}
