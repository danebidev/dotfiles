local lualine = require("lualine")

local mode = {
    "mode",
    fmt = function(str)
        return " " .. str
    end,
}

local filename = {
    "filename",
    newfile_status = true,
    symbols = { modified = "", readonly = "󰏮 " },
    color = function()
        return { fg = vim.bo.modified and "#9ece6a" or nil }
    end,
}

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
}

local function lsp_progress()
    return require("lsp-progress").progress({
        format = function(messages)
            local active_clients = vim.lsp.get_clients()
            local client_count = #active_clients
            if #messages > 0 then
                return " LSP: " .. client_count .. " " .. table.concat(messages, " ")
            end
            if #active_clients <= 0 then
                return " LSP: " .. client_count
            else
                local client_names = {}
                for _, client in ipairs(active_clients) do
                    if client and client.name ~= "" then
                        table.insert(client_names, "[" .. client.name .. "]")
                    end
                end
                return " LSP: " .. client_count .. " " .. table.concat(client_names, " ")
            end
        end,
    })
end

local progress = {
    "progress",
    fmt = function(str)
        if str == "Top" then
            return " 0%%"
        end
        if str == "Bot" then
            return "100%%"
        end
        return str
    end,
}

lualine.setup({
    options = {
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = "",
        refresh = { statusline = 100 },
        disabled_filetypes = { statusline = { "TelescopePrompt", "neo-tree", "Mason", "lazy" } },
        ignore_focus = { "dapui_console", "dapui_scopes", "dapui_breakpoints", "dapui_stacks", "dapui_watches", "dap-repl" },
    },
    sections = {
        lualine_a = { mode },
        lualine_b = { "filetype", filename, diagnostics },
        lualine_c = { lsp_progress },
        lualine_x = {},
        lualine_y = { "diff", "branch" },
        lualine_z = { progress },
    },
})
