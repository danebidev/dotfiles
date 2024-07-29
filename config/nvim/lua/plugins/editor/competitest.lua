return {
    "xeluxee/competitest.nvim",
    opts = {
        compile_directory = "build",
        compile_command = {
            cpp = { exec = "clang++", args = { "-std=c++20", "-g", "-O2", "-Wall", "-Wextra", "-Wshadow", "-fsanitize=address,undefined", "-D", "DEBUG", "$(FABSPATH)", "-o", "$(FNOEXT)" } },
        },

        run_command = {
            cpp = { exec = "build/$(FNOEXT)" },
        },

        testcases_directory = "testcases",
        testcases_use_single_file = true,
        testcases_single_file_format = "$(FNOEXT).testcases",

        template_file = "$(HOME)/programming/cp/template.cpp",
        received_problems_path = "$(HOME)/programming/cp/$(JUDGE)/$(CONTEST)/$(PROBLEM).$(FEXT)",
        received_problems_prompt_path = false,
        received_contests_directory = "$(HOME)/programming/cp/$(JUDGE)/$(CONTEST)",
        received_contest_problems_path = "$(PROBLEM).$(FEXT)",
        received_contests_prompt_directory = false,
        received_contests_prompt_extension = false,
    },
}
