local cmake = require("cmake-tools")

cmake.setup({
    cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1", "-DCMAKE_C_COMPILER=clang", "-DCMAKE_CXX_COMPILER=clang++" },
    cmake_build_directory = "build/${variant:buildType}",
    cmake_dap_configuration = {
        type = "cppdbg",
        MIMode = "gdb",
        miDebuggerPath = "/usr/bin/gdb",
        externalConsole = false,
        stopAtEntry = false,
        setupCommands = {
            {
                text = "-enable-pretty-printing",
                description = "enable pretty printing",
                ignoreFailures = false,
            },
        },
    },
    cmake_executor = {
        name = "quickfix",
        opts = { show = "only_on_error" },
    },
    cmake_terminal = {
        opts = {
            split_size = 15,
        },
    },
})

require("dap").configurations.cpp = {
    name = "Debug current file",
    type = "cppdbg",
    request = "launch",
    program = function()
        return "./build/" .. vim.fn.expand("%:t:r")
    end,
    args = function()
        return vim.split(vim.fn.input("Arguments (cwd is workspace directory): "), " ")
    end,
    MIMode = "gdb",
    miDebuggerPath = "/usr/bin/gdb",
    cwd = "${workspaceFolder}",
    externalConsole = false,
    stopAtEntry = false,
    setupCommands = {
        {
            text = "-enable-pretty-printing",
            description = "enable pretty printing",
            ignoreFailures = false,
        },
    },
}

local function debug_file()
    local file = vim.fn.expand("%")
    local bufname = vim.fn.expand("%:t:r")
    local flags = {
        "-std=c++20",
        "-D DEBUG",
        "-Wall",
        "-Wextra",
    }

    vim.cmd("!mkdir -p build")
    vim.cmd("!g++ -g " .. table.concat(flags, " ") .. " " .. file .. " -o build/" .. bufname)

    require("dap").run(require("dap").configurations.cpp)
end

local function cmake_debug()
    require("cmake-tools.config").build_type = "Debug"
    cmake.generate({}, function()
        cmake.debug({})
    end)
end

return {
    debug_file = debug_file,
    debug_project = cmake_debug,
}
