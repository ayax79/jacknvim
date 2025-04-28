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
        -- LSP configuration
        server = {
            settings = {
                ['rust-analyzer'] = {
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
            adapter = require('rustaceanvim.config').get_codelldb_adapter(codelldb_path, liblldb_path),
        },
    }
end

vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        'selene.yml',
        '.git',
    },
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace",
            },
            workspace = {
                -- ke the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
})


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



        vim.lsp.config('jsonls', {
            cmd = { 'vscode-json-language-server', '--stdio' },
            filetypes = { 'json', 'jsonc' },
            init_options = {
                provideFormatter = true,
            },
            root_markers = { '.git' },
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas(),
                    validate = { enable = true },
                },
            },
        })

        vim.lsp.config('yamlls', {
            cmd = { 'yaml-language-server', '--stdio' },
            filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
            root_markers = { '.git' },
            settings = {
                yaml = {
                    hover = true,
                    completion = true,
                    schemaStore = {
                        -- You must disable built-in schemaStore support if you want to use
                        -- this plugin and its advanced options like `ignore`.
                        enable = false,
                        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                        url = "",
                    },
                    schemas = require('schemastore').yaml.schemas(),
                    customTags = {
                        -- SA/ Cloudformation
                        "!And",
                        "!Base64",
                        "!Cidr",
                        "!Equals",
                        "!FindInp sequence",
                        "!GetAZs",
                        "!GetAtt",
                        "!If",
                        "!ImportValue",
                        "!Join sequence",
                        "!Not",
                        "!Or",
                        "!Ref Scalar",
                        "!Ref",
                        "!Select",
                        "!Split",
                        "!Sub",
                        "!fn",
                        -- gitlab ci
                        "!reference sequence",
                    },
                },
            },
        })

        -- nix language server
        vim.lsp.config('nil_ls', {
            cmd = { 'nil' },
            filetypes = { 'nix' },
            root_markers = { 'flake.nix', '.git' },
            settings = {
                ['nil'] = {
                    autoArchive = true,
                    formatting = {
                        command = { "nixfmt" },
                    }
                },
            },
        })

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
