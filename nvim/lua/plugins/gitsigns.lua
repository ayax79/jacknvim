return {
    "lewis6991/gitsigns.nvim",
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
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true, desc = 'Next uncommitted change' })

                map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true, desc = 'Previous uncommitted change' })

                -- Actions
                -- map('n', '<leader>Gs', gs.stage_hunk, { desc = 'State Hunk' })
                map('n', '<leader>Gr', gs.reset_hunk, { desc = 'Reset Hunk' })
                map('v', '<leader>Gs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    { desc = 'State Hunk' })
                map('v', '<leader>Gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    { desc = 'Reset Hunk' })
                -- map('n', '<leader>GS', gs.stage_buffer, { desc = 'State Buffer' })
                map('n', '<leader>Gu', gs.undo_stage_hunk, { desc = 'Undo State Hunk' })
                map('n', '<leader>GR', gs.reset_buffer, { desc = 'Reset Buffer' })
                map('n', '<leader>Gp', gs.preview_hunk, { desc = 'Preview Hunk' })
                map('n', '<leader>Gb', function() gs.blame_line { full = true } end, { desc = 'Blame Line' })
                map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle Current Line Blame' })
                -- map('n', '<leader>Gd', gs.diffthis, { desc = 'Diff this' })
                map('n', '<leader>GD', function() gs.diffthis('~') end, { desc = 'Diff this ~' })
                map('n', '<leader>td', gs.toggle_deleted, { desc = 'Toggle Deleted' })

                -- Text object
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Git Signs Select Hunk' })
            end
        })
    end,
}
