-- which key
local wk = require("which-key")
local crates = require("crates");

wk.add({
    -- Global Mappings
    { '<space>qla', vim.diagnostic.setloclist, desc = "Set Loclist (all)", },
    {
        '<space>qla',
        function()
            vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Set Loclist (error)",
    },
    { "<space>qqa", vim.diagnostic.setqflist,  desc = "Set Quickfixlist (all)", },
    {
        "<space>qqe",
        function()
            vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Set Quickfixlist (error)",
    },
    { "-",         "<CMD>Oil<CR>",   desc = "Open parent directory", },
    -- LSP Group
    { "<leader>a", group = "Avante" },
    { "<leader>b", group = "Buffers" },
    -- Crates Group
    {
        "<leader>c",
        name = "Crates",
        group = "Crates",
        { "<leader>ct", crates.toggle,                             desc = "Crates Toggle" },
        { "<leader>cr", crates.reload,                             desc = "Crates Reload" },
        { "<leader>cv", crates.show_versions_popup,                desc = "Show Versions Popup" },
        { "<leader>cf", crates.show_features_popup,                desc = "Show Features Popup" },

        { "<leader>cu", crates.update_crate,                       desc = "Update Crate" },
        { "<leader>cs", crates.update_crates,                      desc = "Update Crates" },
        { "<leader>ca", crates.update_all_crates,                  desc = "Update All Crates" },
        { "<leader>cU", crates.upgrade_crate,                      desc = "Upgrade Crate" },
        { "<leader>cS", crates.upgrade_crates,                     desc = "Upgrade Crates" },
        { "<leader>cA", crates.upgrade_all_crates,                 desc = "Upgrade All Crates" },

        { "<leader>cx", crates.expand_plain_crate_to_inline_table, desc = "Expand crate to inline table" },
        { "<leader>cX", crates.extract_crate_into_table,           desc = "Extract crate into table" },

        { "<leader>cH", crates.open_homepage,                      desc = "Open Homepage" },
        { "<leader>cR", crates.open_repository,                    desc = "Open Repository" },
        { "<leader>cD", crates.open_documentation,                 desc = "Open Documentation" },
        { "<leader>cC", crates.open_crates_io,                     desc = "Open Crates IO" },
    },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>j", group = "Molten" },
    {
        "<leader>l",
        name = "LSP",
        group = "LSP",
        { "<leader>ll", vim.lsp.codelens.run, desc = "CodeLens Action", },
        --Debugger Group
        {
            "<leader>lD",
            name = "Debugger",
            group = "Debugger",
            { "<leader>lDb", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint", },
            { "<leader>lDu", require("dapui").toggle,        desc = "Toggle Debugger UI", },
        },
    },
    { "<leader>o", group = "Trouble" },
    { "<leader>q", group = "Quickfix" },
    { "<leader>r", group = "Refactor" },
    { "<leader>s", group = "Search (Picker)" },
    { "<leader>u", group = "Opts" },
    { "<leader>w", group = "Workspaces" },
    { "<leader>/", group = "Search" },
    { "[p",        "<cmd>tabnext<cr>",       desc = "Next Tab Page", },
    { "[P",        "<cmd>tabnext<cr>",       desc = "Previous Tab Page", },
    {
        "<leader>t",
        name = "Tabs",
        group = "Tabs",
        { "<leader>ta",  "<cmd>$tabnew<CR>",  desc = "New Tab", },
        { "<leader>tc",  "<cmd>tabclose<CR>", desc = "Close Tab", },
        { "<leader>to",  "<cmd>tabonly<CR>",  desc = "Close Other Tabs", },
        { "<leader>tn",  "<cmd>tabn<CR>",     desc = "Next Tab", },
        { "<leader>tp",  "<cmd>tabp<CR>",     desc = "Previous Tab", },
        { "<leader>tmp", "<cmd>-tabmove<CR>", desc = "Move Tab Left", },
        { "<leader>tmn", "<cmd>+tabmove<CR>", desc = "Move Tab Right", },
    }
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--
local util = require("util")

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    -- group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }
        -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, util.with_description(opts, "Go to Declaration"))
        -- vim.keymap.set("n", "K", vim.lsp.buf.hover, util.with_description(opts, "LSP hover"))
        -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, util.with_description(opts, "Go to Definition"))
        vim.keymap.set("n", "<M-k>", vim.lsp.buf.signature_help, util.with_description(opts, "Signature Help"))
        vim.keymap.set("n", "gx", vim.lsp.buf.incoming_calls, util.with_description(opts, "Go to incoming calls"))
        vim.keymap.set("n", "gX", vim.lsp.buf.outgoing_calls, util.with_description(opts, "Go to outgoing calls"))
        vim.keymap.set(
            "n",
            "<space>wa",
            vim.lsp.buf.add_workspace_folder,
            util.with_description(opts, "Add workspace folder")
        )
        vim.keymap.set(
            "n",
            "<space>wr",
            vim.lsp.buf.remove_workspace_folder,
            util.with_description(opts, "Remove workspace folder")
        )
        vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, util.with_description(opts, "List workspace folders"))
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, util.with_description(opts, "Type definition"))

        -- local exec_code_action = function()
        --     if vim.bo.filetype == 'rust' then
        --         vim.cmd.RustLsp('codeAction')
        --     else
        --         vim.lsp.buf.code_action()
        --     end
        -- end

        --vim.keymap.set({ "n", "v" }, "<space>la", exec_code_action, util.with_description(opts, "Code Action"))
        vim.keymap.set('v', 'M-K', require('dapui').eval, util.with_description(opts, "DAP Eval Expression"))
    end,
})
