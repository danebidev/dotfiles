local cmake = require("cmake-tools")

cmake.setup({
    cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1", "-DCMAKE_C_COMPILER=clang", "-DCMAKE_CXX_COMPILER=clang++" },
    cmake_build_directory = "build",
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
        return vim.split(vim.fn.input("Arguments (cwd is nvim workspace directory): "), " ")
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

local function create_build_dir()
    vim.cmd("!mkdir -p build")
end

local function build_file(debug)
    local file = vim.fn.expand("%")
    local bufname = vim.fn.expand("%:t:r")
    create_build_dir()
    if debug then
        vim.cmd("!clang++ -std=c++20 -g -o ./build/" .. bufname .. " " .. file)
    else
        vim.cmd("!clang++ -std=c++20 -o ./build/" .. bufname .. " " .. file)
    end
end

local function debug_file()
    build_file(true)
    require("dap").run(require("dap").configurations.cpp)
end

local function cmake_build(debug)
    create_build_dir()
    if debug then
        require("cmake-tools.config").build_type = "Debug"
    else
        require("cmake-tools.config").build_type = "Release"
        cmake.generate({}, function()
            cmake.build({})
        end)
    end
end

local function cmake_debug()
    cmake_build(true)
    cmake.generate({}, function()
        cmake.debug({})
    end)
end

return {
    build_file = function()
        build_file(false)
    end,
    debug_file = debug_file,
    build_project = function()
        cmake_build(false)
    end,
    debug_project = cmake_debug,
}
