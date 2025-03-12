M = {}

-- local home = os.getenv "HOME"
-- local nix_profile_bin = home .. "/.nix-profile/bin"
-- local navic = require("nvim-navic")


M.setup_codelens_refresh = function(client, bufnr)
    local status_ok, codelens_supported = pcall(function()
        return client.supports_method("textDocument/codeLens")
    end)
    if not status_ok or not codelens_supported then
        return
    end
    local group = "lsp_code_lens_refresh"
    local cl_events = { "BufEnter", "InsertLeave" }
    local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
        group = group,
        buffer = bufnr,
        event = cl_events,
    })
    if ok and #cl_autocmds > 0 then
        return
    end
    local cb = function()
        if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_is_valid(bufnr) then
            vim.lsp.codelens.refresh({ bufnr = bufnr })
        end
    end
    vim.api.nvim_create_augroup(group, { clear = false })
    vim.api.nvim_create_autocmd(cl_events, {
        group = group,
        buffer = bufnr,
        callback = cb,
    })
end

M.on_attach_common = function(client, bufnr)
    vim.lsp.inlay_hint.enable(true)
    M.setup_codelens_refresh(client, bufnr)

    local status_ok, doc_symbols_supported = pcall(function()
        return client.supports_method("textDocument/documentSymbol")
    end)

    --     if status_ok and doc_symbols_supported then
    --         navic.attach(client, bufnr)
    --     end
end

function M.get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    return require('blink.cmp').get_lsp_capabilities(capabilities)
end

M.setup = function()
    -- require("mason").setup()
    -- require("mason-lspconfig").setup()
    -- -- only manage stuff in here when nix won't work
    -- require('mason-tool-installer').setup({
    --     ensure_installed = {
    --         "codelldb",
    --         -- "java-debug-adapter",
    --         -- "java-test",
    --         -- "jdtls",
    --         -- "lombok-nightly",
    --         -- "openjdk-17",
    --         -- "rust-analyzer",
    --         -- "spring-boot-tools",
    --     }
    -- })
    --
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
        virtual_text = true,
        signs = true,
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        --     float = {
        --         border = "rounded",
        --         source = "always",
        --         header = "",
        --         prefix = "",
        --     },
    })

    --Set completeopt to have a better completion experience
    -- :help completeopt
    -- menuone: popup even when there's only one match
    -- noinsert: Do not insert text until a selection is made
    -- noselect: Do not select, force to select one from the menu
    -- shortness: avoid showing extra messages when using completion
    -- updatetime: set updatetime for CursorHold
    -- vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
    -- vim.opt.shortmess = vim.opt.shortmess + { c = true }
    -- vim.api.nvim_set_option_value("updatetime", 300, { scope = 'global' })

    -- -- Fixed column for diagnostics to appear
    -- -- Show autodiagnostic popup on cursor hover_range
    -- -- Goto previous / next diagnostic warning / error
    -- -- Show inlay_hints more frequently
    -- vim.cmd([[
    -- set signcolumn=yes
    -- autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
    -- ]
    --])

    require("lsp-colors").setup()

    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()
    dap.adapters.lldb = {
        type = "executable",
        command = codelldb_path,
        name = "lldb",
    }

    vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end

    local capabilities = M.get_capabilities()
    local lspconfig = require("lspconfig")



    --------------------------------------------------------
    --- LUA configuration
    --------------------------------------------------------

    lspconfig.lua_ls.setup({
        on_attach = M.on_attach_common,
        capabilities = capabilities,
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
            },
        },
    })

    --------------------------------------------------------
    --- YAML configuration
    --------------------------------------------------------

    lspconfig.yamlls.setup {
        on_attach = M.on_attach_common,
        capabilities = capabilities,
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
                    -- SAM / Cloudformation
                    "!fn",
                    "!And",
                    "!If",
                    "!Not",
                    "!Equals",
                    "!Or",
                    "!FindInMap sequence",
                    "!Base64",
                    "!Cidr",
                    "!Ref",
                    "!Ref Scalar",
                    "!Sub",
                    "!GetAtt",
                    "!GetAZs",
                    "!ImportValue",
                    "!Select",
                    "!Split",
                    "!Join sequence",
                    -- gitlab ci
                    "!reference sequence",
                },
            },
        },
    }

    --------------------------------------------------------
    --- JSON LS configuration
    --------------------------------------------------------

    lspconfig.jsonls.setup {
        on_attach = M.on_attach_common,
        settings = {
            json = {
                schemas = require('schemastore').json.schemas(),
                validate = { enable = true },
            },
        },
    }

    --------------------------------------------------------
    --- NONE-LS configuration
    --------------------------------------------------------

    local null_ls = require("null-ls")

    null_ls.setup({
        sources = {
            -- null_ls.builtins.diagnostics.eslint,
            null_ls.builtins.completion.spell,
            null_ls.builtins.formatting.alejandra,
            null_ls.builtins.formatting.black,
            null_ls.builtins.diagnostics.tidy,
            -- null_ls.builtins.formatting.yq.with({
            --     extra_args = { '-y' },
            -- }),
        },
    })

    --------------------------------------------------------
    --- PYTHON CONFIGURATION
    --------------------------------------------------------
    lspconfig.pyright.setup {}

    --------------------------------------------------------
    --- NIL LS CONFIGURATION (NIX)
    --------------------------------------------------------
    lspconfig.nil_ls.setup {
        settings = {
            ['nil'] = {
                autoArchive = true,
            },
        },
    }

    --------------------------------------------------------
    --- NUSHELL CONFIGURATION
    --------------------------------------------------------
    require 'lspconfig'.nushell.setup {
        on_attach = M.on_attach_common,
        capabilities = capabilities,
    }

    --------------------------------------------------------
    --- JAVA CONFIGURATION
    --------------------------------------------------------
    -- require('java').setup()
    -- require('lspconfig').jdtls.setup({})

    --------------------------------------------------------
    --- GO LANG CONFIGURATION
    --------------------------------------------------------
    lspconfig.gopls.setup({
        on_attach = M.on_attach_common,
        capabilities = capabilities,
    })

    --------------------------------------------------------
    --- METALS (scala) CONFIGURATION
    --------------------------------------------------------
    local metals_config = require("metals").bare_config()

    -- Example of settings
    metals_config.settings = {
        showImplicitArguments = true,
        excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
    }

    -- *READ THIS*
    -- I *highly* recommend setting statusBarProvider to true, however if you do,
    -- you *have* to have a setting to display this in your statusline or else
    -- you'll not see any messages from metals. There is more info in the help
    -- docs about this
    metals_config.init_options.statusBarProvider = "off"

    -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
    metals_config.capabilities = M.get_capabilities()

    metals_config.on_attach = function(client, bufnr)
        require("metals").setup_dap()
        M.on_attach_common(client, bufnr)
    end

    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt" },
        callback = function()
            require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
    })

    --------------------------------------------------------
    --- TYPESCRIPT CONFIGURATION
    --------------------------------------------------------
    lspconfig.ts_ls.setup({
        on_attach = M.on_attach_common,
        capabilities = capabilities,
    })

    --------------------------------------------------------
    --- TERRAFORM CONFIGURATION
    --------------------------------------------------------
    lspconfig.terraformls.setup({
        on_attach = M.on_attach_common,
        capabilities = capabilities,
    })
end

return M
