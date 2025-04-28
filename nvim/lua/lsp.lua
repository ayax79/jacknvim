local codelldb_home = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/'
local codelldb_path = codelldb_home .. 'adapter/codelldb'

local liblldb_path = codelldb_home .. 'lldb/lib/liblldb'
local this_os = vim.uv.os_uname().sysname;

-- The path is different on Windows
if this_os:find "Windows" then
    codelldb_path = codelldb_home .. "adapter\\codelldb.exe"
    liblldb_path = codelldb_home .. "lldb\\bin\\liblldb.dll"
else
    -- The liblldb extension is .so for Linux and .dylib for MacOS
    liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
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
            adapter = require('rustaceanvim.config').get_codelldb_adapter(codelldb_path, liblldb_path),
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

return {

    setup = function()
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup()
        dap.adapters.lldb = {
            type = "executable",
            command = codelldb_path,
            name = "lldb",
        }

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end

        vim.lsp.enable({
            'jsonls',
            'lua_ls',
            'nil_ls',
            'null-ls',
            'nushell',
            'pyright',
            'terraformls',
            'ts_ls',
            'yamlls',
        })
    end
}
