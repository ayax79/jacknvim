-- All deferred plugin setups (run after VimEnter)
local lazyload = require("lazyload")

-- Treesitter
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name == "nvim-treesitter" then
            vim.cmd("TSUpdate")
        end
    end,
})

-- On the main branch, nvim-treesitter uses vim.treesitter directly
-- and auto-installs parsers. The old configs module is gone.
require("tree-sitter-manager").setup({
    ensure_installed = {
        "comment", "css", "go", "gomod", "gosum", "gotmpl", "gowork",
        "html", "json", "lua", "markdown_inline", "markdown", "nix",
        "nu", "regex", "rust", "scss", "sql", "svelte", "toml",
        "tsx", "typst", "vue",
    },
    auto_install = true,
})

-- Blink completion
require("blink.cmp").setup({
    keymap = { preset = 'default' },
    appearance = { use_nvim_cmp_as_default = false, nerd_font_variant = 'mono' },
    completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = { draw = { treesitter = { "lsp" } } },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = false },
    },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    fuzzy = { implementation = "prefer_rust_with_warning" }
})

-- Oil
local detail = false
require("oil").setup({
    win_options = { signcolumn = "yes:2" },
    view_options = { show_hidden = true },
    keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["F8"] = "actions.refresh",
        ["gi"] = {
            desc = "Toggle file detail view",
            callback = function()
                detail = not detail
                if detail then
                    require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                else
                    require("oil").set_columns({ "icon" })
                end
            end,
        }
    }
})
require("oil-git-status").setup({})

-- Lualine
require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = {}, winbar = {} },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = { statusline = 1000, winbar = 1000 },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { 'filename', file_status = true, path = 1, shortening_target = 40 } },
        lualine_x = {
            {
                'lsp_status',
                icon = '',
                symbols = {
                    spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                    done = '✓',
                    separator = ' ',
                },
                ignore_lsp = { "copilot" },
                show_name = true,
            },
            'filetype',
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { "avante", "fzf", "oil", "trouble", "quickfix" },
})

-- Tabby
require('tabby').setup({
    preset = 'active_wins_at_tail',
    option = {
        theme = {
            fill = 'TabLineFill',
            head = 'TabLine',
            current_tab = 'TabLineSel',
            tab = 'TabLine',
            win = 'TabLine',
            tail = 'TabLine',
        },
        nerdfont = true,
        lualine_theme = nil,
        tab_name = { name_fallback = function(tabid) return tabid end },
        buf_name = { mode = 'unique' },
    },
})

-- Which-key + Crates + Keys
lazyload.on_vim_enter(function()
    require("which-key").setup({ preset = "helix" })
    require("crates").setup({})
    require("keys")
end)

-- Trouble
lazyload.on_vim_enter(function()
    require("trouble").setup({})
    vim.keymap.set("n", "<leader>ox", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
    vim.keymap.set("n", "<leader>oX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        { desc = "Buffer Diagnostics (Trouble)" })
    vim.keymap.set("n", "<leader>os", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
    vim.keymap.set("n", "<leader>ol", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        { desc = "LSP Definitions / references / ... (Trouble)" })
    vim.keymap.set("n", "<leader>oL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
    vim.keymap.set("n", "<leader>oQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
end)

-- Conform
require("conform").setup({
    formatters_by_ft = {
        nu = { "topiary_nu" },
        markdown = { "dprint" },
        toml = { "dprint" },
    },
    formatters = {
        topiary_nu = { command = "topiary", args = { "format", "--language", "nu" } },
    },
    default_format_opts = { async = true, lsp_format = "fallback", timeout_ms = 10000 },
})
vim.keymap.set({ "n", "v" }, "<leader>lf", function() require("conform").format() end, { desc = "Format" })

-- Gitsigns
require("gitsigns").setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end
        map('n', ']c', function()
            if vim.wo.diff then vim.cmd.normal({ ']c', bang = true }) else gs.nav_hunk('next') end
        end, { desc = 'Next uncommitted change' })
        map('n', '[c', function()
            if vim.wo.diff then vim.cmd.normal({ '[c', bang = true }) else gs.nav_hunk('prev') end
        end, { desc = 'Previous uncommitted change' })
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage Hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset Hunk' })
        map('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
            { desc = 'Stage Hunk' })
        map('v', '<leader>hr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
            { desc = 'Reset Hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage Buffer' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset Buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview Hunk' })
        map('n', '<leader>hi', gs.preview_hunk_inline, { desc = 'Preview Hunk Inline' })
        map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, { desc = 'Blame Line' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'Diff This' })
        map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Diff This ~" })
        map('n', '<leader>hQ', function() gs.setqflist('all') end, { desc = 'Set QF list (all)' })
        map('n', '<leader>hq', gs.setqflist, { desc = 'Set QF list (unstaged)' })
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle Current Line Blame' })
        map('n', '<leader>tw', gs.toggle_word_diff, { desc = 'Toggle Word Diff' })
        map({ 'o', 'x' }, 'ih', gs.select_hunk, { desc = 'Select Hunk' })
    end
})

-- Git Conflict
lazyload.on_vim_enter(function()
    require('git-conflict').setup({
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = 'copen',
        highlights = { incoming = 'DiffAdd', current = 'DiffText' }
    })
end)

-- Mason
require("mason").setup({})

-- Neoconf
lazyload.on_vim_enter(function()
    require("neoconf").setup({})
end)

-- nvim-lint
lazyload.on_vim_enter(function()
    local lint = require("lint")
    lint.linters_by_ft = { fish = { "fish" }, markdown = { "markdownlint-cli2" } }
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function() require("lint").try_lint() end
    })
end)

-- DAP
lazyload.on_vim_enter(function()
    require("nvim-dap-virtual-text").setup()
    require("dapui").setup()

    -- Initialize DAP (moved from lsp.lua since it requires dap module)
    local dap, dapui = require("dap"), require("dapui")
    dap.adapters.lldb = {
        type = "executable",
        command = vim.g.codelldb_path,
        name = "lldb",
    }
    dap.configurations.rust = {
        type = "lldb",
        request = "launch",
        cargo = {
            args = { "test", "foo", "--", "--test-threads=3" },
            env = { RUSTFLAGS = "-Clinker=ld.mold" },
            cwd = "${workspaceFolder}",
            problemMatcher = "$rustc",
        }
    }
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
end)

-- Neotest
lazyload.on_vim_enter(function()
    require('neotest').setup({
        adapters = { require('rustaceanvim.neotest') },
    })
end)

-- Fidget
lazyload.on_vim_enter(function()
    require("fidget").setup({})
end)

-- Copilot
lazyload.on_vim_enter(function()
    require("copilot").setup({
        suggestion = { enabled = true, auto_trigger = true },
        panel = { enabled = true },
        model = "claude-sonnet-4.5",
    })
    vim.keymap.set("i", "<C-J>", function() require("copilot.suggestion").accept() end,
        { desc = "Accept Copilot suggestion" })
    vim.keymap.set("i", "<C-K>", function() require("copilot.suggestion").dismiss() end,
        { desc = "Dismiss Copilot suggestion" })
    vim.keymap.set("i", "<C-H>", function() require("copilot.suggestion").prev() end, { desc = "Previous Suggestion" })
    vim.keymap.set("i", "<C-L>", function() require("copilot.suggestion").next() end, { desc = "Next Suggestion" })
end)

-- Avante
lazyload.on_vim_enter(function()
    vim.api.nvim_create_autocmd("PackChanged", {
        callback = function(ev)
            if ev.data.spec.name == "avante.nvim" then
                vim.fn.system("make -C " .. ev.data.path)
            end
        end,
    })
    require("img-clip").setup({
        default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
        },
    })
    require("avante").setup({
        provider = "goose",
        input = {
            provider = "snacks",
            provider_opts = { title = "Avante Input", icon = " " },
        }
    })
end)

-- Multicursor
lazyload.on_vim_enter(function()
    local mc = require("multicursor-nvim")
    mc.setup()
    local set = vim.keymap.set
    set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end, { desc = "Add MultiCursor Above" })
    set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end, { desc = "Add MultiCursor Below" })
    set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end, { desc = "Skip MultiCursor Above" })
    set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end, { desc = "Skip MultiCursor Below" })
    set({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end, { desc = "Add MultiCursor Next Match" })
    set({ "n", "x" }, "M-s", function() mc.matchSkipCursor(1) end, { desc = "Skip MultiCursor Next Match" })
    set({ "n", "x" }, "M-n", function() mc.matchAddCursor(-1) end, { desc = "Add MultiCursor Previous Match" })
    set({ "n", "x" }, "M-S", function() mc.matchSkipCursor(-1) end, { desc = "Skip MultiCursor Previous Match" })
    set({ "n", "x" }, "mw", function() mc.operator({ motion = "iw", visual = true }) end)
    set("n", "mW", mc.operator, { desc = "MultiCursor Operator" })
    set({ "n", "x" }, "<leader>A", mc.matchAllAddCursors, { desc = "Add MultiCursor All Matches" })
    set({ "n", "x" }, "<left>", mc.nextCursor, { desc = "Next MultiCursor" })
    set({ "n", "x" }, "<right>", mc.prevCursor, { desc = "Previous MultiCursor" })
    set({ "n", "x" }, "<leader>x", mc.deleteCursor, { desc = "Delete MultiCursor" })
    set("n", "<c-leftmouse>", mc.handleMouse, { desc = "Add MultiCursor with Mouse" })
    set("n", "<c-leftdrag>", mc.handleMouseDrag, { desc = "Add MultiCursor with Mouse Drag" })
    set("n", "<c-leftrelease>", mc.handleMouseRelease, { desc = "Add MultiCursor with Mouse Release" })
    set({ "n", "x" }, "<c-q>", mc.toggleCursor, { desc = "Toggle MultiCursor" })
    set({ "n", "x" }, "<leader><c-q>", mc.duplicateCursors, { desc = "Duplicate MultiCursors" })
    set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        elseif mc.hasCursors() then
            mc.clearCursors()
        end
    end, { desc = "Clear MultiCursors if present" })
    set("n", "<leader>Cv", mc.restoreCursors, { desc = "Restore MultiCursors" })
    set("n", "<leader>a", mc.alignCursors, { desc = "Align MultiCursors" })
    set("x", "S", mc.splitCursors, { desc = "Split MultiCursors" })
    set("x", "I", mc.insertVisual, { desc = "Insert MultiCursors" })
    set("x", "A", mc.appendVisual, { desc = "Append MultiCursors" })
    set("x", "M", mc.matchCursors)
    set("x", "<leader>t", function() mc.transposeCursors(1) end, { desc = "Transpose MultiCursors" })
    set("x", "<leader>T", function() mc.transposeCursors(-1) end, { desc = "Transpose MultiCursors Reverse" })
    set({ "x", "n" }, "<c-i>", mc.jumpForward, { desc = "MultiCursor Jump Forward" })
    set({ "x", "n" }, "<c-o>", mc.jumpBackward, { desc = "MultiCursor Jump Backward" })
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { link = "Cursor" })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
end)

-- Leetcode
lazyload.on_vim_enter(function()
    require("leetcode").setup({
        lang = "rust",
        injector = {
            ['rust'] = {
                before = { '#[allow(dead_code)]', 'fn main(){}', '#[allow(dead_code)]', 'struct Solution;' },
            },
        },
        hooks = {
            ['question_enter'] = {
                function(question)
                    if question.lang ~= 'rust' then return end
                    local problem_dir = vim.fn.stdpath 'data' .. '/leetcode/Cargo.toml'
                    local content =
                    "[package]\nname = \"leetcode\"\nedition = \"2024\"\n\n[lib]\nname = \"%s\"\npath = \"%s\"\n\n[dependencies]\nrand = \"0.8\"\nregex = \"1\"\nitertools = \"0.14.0\"\n"
                    local file = io.open(problem_dir, 'w')
                    if file then
                        file:write(content:format(question.q.frontend_id, question:path()))
                        file:close()
                    end
                end,
            },
        },
    })
end)

-- Mini
require('mini.align').setup()
require('mini.ai').setup()
require('mini.icons').setup()
require('mini.move').setup()
require('mini.jump2d').setup()
require('mini.splitjoin').setup()
require('mini.surround').setup()

-- Tmux Navigator
vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true })
vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true })
vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true })
vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true })
vim.keymap.set("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", { silent = true })

-- Yazi
lazyload.on_vim_enter(function()
    vim.keymap.set("n", "<leader>-", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })
    vim.keymap.set("n", "<leader>cw", "<cmd>Yazi cwd<cr>", { desc = "Open the file manager in nvim's working directory" })
    vim.keymap.set("n", "<c-up>", "<cmd>Yazi toggle<cr>", { desc = "Resume the last yazi session" })
end)

-- ts-comments
require("ts-comments").setup({})

-- tree-sitter-language-injection
require("tree-sitter-language-injection").setup({})

-- key-analyzer
require("key-analyzer").setup({})

-- Enable LSP servers (after SchemaStore is on rtp)
vim.lsp.enable({
    "nixd",
    "nil_ls",
    "lua_ls",
    "nushell",
    "yamlls",
    "pyright",
    "ruff",
    "marksman",
    "ts_ls",
})

-- Lazydev (lua ft)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    once = true,
    callback = function()
        require("lazydev").setup({
            library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
        })
    end,
})

-- nvim-metals (Scala)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt" },
    once = true,
    callback = function()
        local metals_config = require("metals").bare_config()
        metals_config.on_attach = function(client, bufnr) end

        local dap = require("dap")
        dap.configurations.scala = {
            { type = "scala", request = "launch", name = "RunOrTest",   metals = { runType = "runOrTestFile" } },
            { type = "scala", request = "launch", name = "Test Target", metals = { runType = "testTarget" } },
        }

        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "scala", "sbt" },
            callback = function() require("metals").initialize_or_attach(metals_config) end,
            group = nvim_metals_group,
        })
        require("metals").initialize_or_attach(metals_config)
    end,
})

-- nvim-coverage (rust ft)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    once = true,
    callback = function() require("coverage").setup() end,
})
