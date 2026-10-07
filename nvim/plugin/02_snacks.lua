-- Snacks.nvim setup (eager - priority plugin)
local function get_tabs()
    local tabs = {}
    local tabpages = vim.api.nvim_list_tabpages()
    for i, tabpage in ipairs(tabpages) do
        local wins = vim.api.nvim_tabpage_list_wins(tabpage)
        local cur_win = vim.api.nvim_tabpage_get_win(tabpage)
        local buf = vim.api.nvim_win_get_buf(cur_win)
        local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':t')
        if name == '' then name = '[No Name]' end

        local preview_lines = {}
        table.insert(preview_lines, ('Tab %d: %d window%s'):format(i, #wins, #wins == 1 and '' or 's'))
        table.insert(preview_lines, ('%-6s %-8s %s'):format('WinID', 'Buf#', 'File'))
        table.insert(preview_lines, string.rep('-', 40))
        for _, win in ipairs(wins) do
            local win_buf = vim.api.nvim_win_get_buf(win)
            local bufname = vim.api.nvim_buf_get_name(win_buf)
            if bufname == '' then bufname = '[No Name]' end
            bufname = vim.fn.fnamemodify(bufname, ':~:.')
            local win_marker = (win == cur_win) and '->' or '  '
            table.insert(preview_lines, ('%s %-6d %-8d %s'):format(win_marker, win, win_buf, bufname))
        end
        if #wins == 0 then table.insert(preview_lines, 'No windows in tab') end

        table.insert(tabs, {
            idx = i,
            text = ('Tab %d: %s'):format(i, name),
            tabnr = i,
            tabpage = tabpage,
            preview = {
                text = table.concat(preview_lines, '\n'),
                ft = 'text',
            },
        })
    end
    return tabs
end

require("snacks").setup({
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    image = {
        enabled = true,
        convert = { notify = false },
    },
    notifier = {
        enabled = true,
        timeout = 3000,
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = { notification = {} },
    lazygit = {
        enabled = true,
        configure = true,
        config = {
            os = { editPreset = "nvim-remote" },
            gui = { nerdFontsVersion = "3" },
        },
    }
})

-- Keymaps
local map = vim.keymap.set
map("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
map("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>//", function() Snacks.picker.grep() end, { desc = "Grep" })
map("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
map("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })
map("n", "<leader>e", function() Snacks.explorer() end, { desc = "File Explorer" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = "Find Config File" })
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
map("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })
map("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
map("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
map("n", "<leader>gw", function()
    Snacks.picker({
        title = "Git Worktrees",
        finder = function(opts, ctx)
            return require("snacks.picker.source.proc").proc(vim.tbl_extend("force", opts, {
                cmd = "git",
                args = { "worktree", "list" },
                transform = function(item)
                    local line = item.text
                    if not line or line == "" then return false end
                    local path, hash, branch = line:match("^(%S+)%s+(%S+)%s+%[(.-)%]")
                    if not path then
                        -- bare worktree or detached HEAD
                        path, hash = line:match("^(%S+)%s+(%S+)")
                        branch = hash or ""
                    end
                    if not path then return false end
                    item.file = path
                    item.text = ("%s [%s]"):format(path, branch or "")
                    item.path = path
                    item.branch = branch or ""
                end,
            }), ctx)
        end,
        format = "text",
        confirm = function(picker, item)
            picker:close()
            if item and item.path then
                vim.fn.chdir(item.path)
                vim.notify("Changed directory to " .. item.path, vim.log.levels.INFO)
            end
        end,
        preview = function(ctx)
            local item = ctx.item
            if not item or not item.path then return end
            local lines = {}
            table.insert(lines, "Worktree: " .. item.path)
            table.insert(lines, "Branch:   " .. (item.branch or ""))
            table.insert(lines, "")
            table.insert(lines, "--- Recent commits ---")
            local result = vim.fn.systemlist({ "git", "-C", item.path, "log", "--oneline", "-20" })
            vim.list_extend(lines, result)
            return { text = table.concat(lines, "\n"), ft = "git" }
        end,
    })
end, { desc = "Git Worktrees" })
map("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
map("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
map("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
map("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })
map("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
map("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
map("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })
map("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
map("n", '<leader>s/', function() Snacks.picker.search_history() end, { desc = "Search History" })
map("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
map("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
map("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
map("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
map("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
map("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
map("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
map("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
map("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
map("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
map("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
map("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
map("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
map("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" })
map("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
map("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
map("n", "grr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
map("n", "gri", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
map("n", "gai", function() Snacks.picker.lsp_incoming_calls() end, { desc = "C[a]lls Incoming" })
map("n", "gao", function() Snacks.picker.lsp_outgoing_calls() end, { desc = "C[a]lls Outgoing" })
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })
map("n", "<leader>z", function() Snacks.zen() end, { desc = "Toggle Zen Mode" })
map("n", "<leader>Z", function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })
map("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
map("n", "<leader>bD", function() Snacks.bufdelete.invisible() end, { desc = "Delete Invisible Buffers" })
map("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename File" })
map({ "n", "v" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
map("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
map("n", "<c-/>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
map("n", "<c-_>", function() Snacks.terminal() end, { desc = "which_key_ignore" })
map({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
map({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
map("n", "<leader>gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub Issues (open)" })
map("n", "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, { desc = "GitHub Issues (all)" })
map("n", "<leader>gp", function() Snacks.picker.gh_pr() end, { desc = "GitHub Pull Requests (open)" })
map("n", "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, { desc = "GitHub Pull Requests (all)" })
map("n", "<leader>N", function()
    Snacks.win({
        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
        width = 0.6,
        height = 0.6,
        wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3 },
    })
end, { desc = "Neovim News" })
map("n", '<leader>st', function()
    Snacks.picker.pick {
        title = "AST Grep",
        format = 'file',
        notify = false,
        show_empty = true,
        live = true,
        supports_live = true,
        finder = function(opts, ctx)
            local cmd = 'ast-grep'
            local args = { 'run', '--color=never', '--json=stream' }
            if vim.fn.has 'win32' == 1 then cmd = 'sg' end
            if opts.hidden then table.insert(args, '--no-ignore=hidden') end
            if opts.ignored then table.insert(args, '--no-ignore=vcs') end
            local pattern, pargs = Snacks.picker.util.parse(ctx.filter.search)
            table.insert(args, string.format('--pattern=%s', pattern))
            vim.list_extend(args, pargs)
            opts = vim.tbl_extend('force', opts, {
                cmd = cmd,
                args = args,
                transform = function(item)
                    local entry = vim.json.decode(item.text)
                    if vim.tbl_isempty(entry) then
                        return false
                    else
                        local start = entry.range.start
                        item.cwd = vim.fs.normalize(opts and opts.cwd or vim.uv.cwd() or '.') or nil
                        item.file = entry.file
                        item.line = entry.text
                        item.pos = { tonumber(start.line) + 1, tonumber(start.column) }
                    end
                end,
            })
            return require('snacks.picker.source.proc').proc(opts, ctx)
        end,
    }
end, { desc = "AST Grep" })
map("n", "<leader>sT", function()
    local items = get_tabs()
    Snacks.picker({
        title = 'Tab Pages',
        items = items,
        format = 'text',
        confirm = function(picker, item)
            picker:close()
            vim.cmd(('tabnext %d'):format(item.tabnr))
        end,
        preview = 'preview',
        actions = {
            close_tab = function(picker, item)
                picker:close()
                vim.cmd(('tabclose %d'):format(item.tabnr))
            end,
        },
        win = { input = { keys = { ['d'] = 'close_tab' } } },
    })
end, { desc = "Tab" })

-- Toggles (deferred)
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    once = true,
    callback = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        _G.dd = function(...) Snacks.debug.inspect(...) end
        ---@diagnostic disable-next-line: duplicate-set-field
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd

        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
            "<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
    end,
})
