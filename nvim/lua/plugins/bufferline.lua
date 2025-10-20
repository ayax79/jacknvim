return {
    'akinsho/bufferline.nvim',
    version = "*",
    enabled = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            diagnostics = "nvim_lsp",
            hover = {
                enabled = true,
                delay = 200,
                reveal = { 'close' },
            },
        }
    },
}
