return {
    'akinsho/bufferline.nvim',
    version = "*",
    enabled = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
        options = {
            -- stylua: ignore
            close_command = function(n) Snacks.bufdelete(n) end,
            -- stylua: ignore
            right_mouse_command = function(n) Snacks.bufdelete(n) end,
            always_show_bufferline = false,
            diagnostics = "nvim_lsp",
            offsets = {
                filetype = "snacks_layout_box",
            },
            -- hover = {
            --     enabled = true,
            --     delay = 200,
            --     reveal = { 'close' },
            -- },
        }
    },
}
