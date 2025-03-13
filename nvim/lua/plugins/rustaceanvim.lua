local codelldb_home = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/'
local codelldb_path = codelldb_home .. 'adapter/codelldb'

vim.g.rustaceanvim = function()
    -- Update this path
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
    local cfg = require('rustaceanvim.config')
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
        -- LSP configuration
        server = {
            -- on_attach = function(client, bufnr)
            --     -- M.on_attach_common(client, bufnr)
            --     -- Hover actions
            --
            --     M.setup_codelens_refresh(client, bufnr)
            -- end,
            -- rust-analyzer language server configuration
            -- settings = {
            --     ['rust-analyzer'] = {
            --         initialization_options = {
            --             -- get more cargo-less diagnostics from rust-analyzer,
            --             -- which might include false-positives (those can be turned off by their names)
            --             diagnostics = {
            --                 experimental = {
            --                     enable = true,
            --                 }
            --             },
            --             -- To disable the checking entirely
            --             -- (ignores all cargo and check settings below)
            --             checkOnSave = false,
            --             -- To check the `lib` target only.
            --             cargo = {
            --                 allTargets = false
            --             },
            --             -- Use `-p` instead of `--workspace` for cargo check
            --             check = {
            --                 workspace = false,
            --             }
            --         }
            --     },
            -- },
            settings = {
                ['rust-analyzer'] = {
                    -- check = {
                    --     features = "all",
                    -- },
                    -- cargo = {
                    --     autoReload = true,
                    --     -- features = "all",
                    -- },
                    -- -- procMacro = { enable = true },
                    diagnostics = { disabled = { "inactive-code" } },
                    files = {
                        excludeDirs = {
                            ".dart_tool",
                            ".flatpak-builder",
                            ".git",
                            ".gitlab",
                            ".gitlab-ci",
                            ".gradle",
                            ".idea",
                            ".next",
                            ".project",
                            ".scannerwork",
                            ".settings",
                            ".venv",
                            "_build",
                            "archetype-resources",
                            "bin",
                            "hooks",
                            "node_modules",
                            "po",
                            "screenshots",
                            "target"
                        }
                    }
                },
            }
        },
        -- DAP configuration
        dap = {
            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
    }
end

return {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = true,
};
