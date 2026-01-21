return {
    'nvim-mini/mini.nvim',
    version = '*',
    enabled = true,
    lazy = false,
    config = function()
        require('mini.align').setup()
        require('mini.ai').setup()
        -- require('mini.diff').setup()
        -- require('mini.git').setup()
        require('mini.icons').setup()
        require('mini.move').setup()
        -- require('mini.notify').setup({
        --     -- This isn't necessary because noice provides LSP status
        --     lsp_progress = {
        --         enable = false,
        --     }
        -- })
        require('mini.pairs').setup()
        -- require('mini.pairs').setup({
        --     modes = { insert = true, command = true, terminal = false },
        --     -- skip autopair when next character is one of these
        --     skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        --     -- skip autopair when the cursor is inside these treesitter nodes
        --     skip_ts = { "string" },
        --     -- skip autopair when next character is closing pair
        --     -- and there are more closing pairs than opening pairs
        --     skip_unbalanced = true,
        --     -- better deal with markdown code blocks
        --     markdown = true,
        -- })
        -- require('mini.jump').setup()
        require('mini.jump2d').setup()
        require('mini.splitjoin').setup()
        -- require('mini.sessions').setup()
        require('mini.surround').setup()
    end,
}
