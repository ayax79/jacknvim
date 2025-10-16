return {
    "lewis6991/gitsigns.nvim",
    enabled = false,
    config = function()
        require("gitsigns").setup({
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gs.nav_hunk('next')
                    end
                end, { desc = 'Next uncommitted change' })

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gs.nav_hunk('prev')
                    end
                end, { desc = 'Previous uncommitted change' })

                -- Actions

                map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage Hunk' })
                map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset Hunk' })

                map('v', '<leader>hs', function()
                    gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, { desc = 'Stage Hunk' })

                map('v', '<leader>hr', function()
                    gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, { desc = 'Reset Hunk' })

                map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage Buffer' })
                map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset Buffer' })
                map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview Hunk' })
                map('n', '<leader>hi', gs.preview_hunk_inline, { desc = 'Preview Hunk Inline' })

                map('n', '<leader>hb', function()
                    gs.blame_line({ full = true })
                end, { desc = 'Blame Line' })

                map('n', '<leader>hd', gs.diffthis, { desc = 'Diff This' })

                map('n', '<leader>hD', function()
                    gs.diffthis('~')
                end, { desc = "Diff This ~" })

                map('n', '<leader>hQ', function() gs.setqflist('all') end, { desc = 'Set QF list (all)' })
                map('n', '<leader>hq', gs.setqflist, { desc = 'Set QF list (unstaged)' })

                -- Toggles
                map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle Current Line Blame' })
                map('n', '<leader>tw', gs.toggle_word_diff, { desc = 'Toggle Word Diff' })

                -- Text object
                map({ 'o', 'x' }, 'ih', gs.select_hunk, { desc = 'Select Hunk' })
            end
        })
    end,
}
