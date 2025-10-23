vim.g.codelldb_home = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/'
vim.g.codelldb_path = vim.g.codelldb_home .. 'adapter/codelldb'
vim.g.liblldb_path = vim.g.codelldb_home .. 'lldb/lib/liblldb'

local this_os = vim.uv.os_uname().sysname;

if this_os:find "Windows" then
    vim.g.codelldb_path = vim.g.codelldb_home .. "adapter\\codelldb.exe"
    vim.g.liblldb_path = vim.g.codelldb_home .. "lldb\\bin\\liblldb.dll"
else
    -- The liblldb extension is .so for Linux and .dylib for mac os
    vim.g.liblldb_path = vim.g.liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
end

vim.g.rustaceanvim = function()
    return {
        -- Plugin configuration
        tools = {
            float_win_config = {
                border = {
                    { '╭', 'FloatBorder' },
                    { '─', 'FloatBorder' },
                    { '╮', 'FloatBorder' },
                    { '│', 'FloatBorder' },
                    { '╯', 'FloatBorder' },
                    { '─', 'FloatBorder' },
                    { '╰', 'FloatBorder' },
                    { '│', 'FloatBorder' },
                }
            },
        },
        dap = {
            adapter = require('rustaceanvim.config').get_codelldb_adapter(vim.g.codelldb_path, vim.g.liblldb_path),
        },
    }
end

-- Remove once this actually works
-- LSP Diagnostics Options Setup
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = "",
    })
end

sign({ name = "DiagnosticSignError", text = "" })
sign({ name = "DiagnosticSignWarn", text = "" })
sign({ name = "DiagnosticSignHint", text = "" })
sign({ name = "DiagnosticSignInfo", text = "" })


vim.diagnostic.config({
    virtual_lines = {
        severity = {
            min = vim.diagnostic.severity.ERROR,
        },
    },
    virtual_text = {
        severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.WARN,
        },
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        }
    },
    linehl = {
        [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
    },
    numhl = {
        [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
})

vim.g.initialize_dap = function()
    -- The path is different on Windows
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()
    dap.adapters.lldb = {
        type = "executable",
        command = vim.g.codelldb_path,
        name = "lldb",
    }

    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
end

