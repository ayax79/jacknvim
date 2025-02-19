return {
    'nvimdev/lspsaga.nvim',
    event = "LspAttach",
    config = function()
        require('lspsaga').setup({
            lightbulb = {
                -- Don't show lightbulb in the status column... causes it to bounce
                sign = false,
            },
            diagnostic = {
                keys = {
                    quit = '<ESC>',
                },
            },
            code_action = {
                keys = {
                    quit = '<ESC>',
                },
            },
            definition = {
                keys = {
                    quit = '<ESC>',
                },
            },
        })
    end,
    dependencies = {
        'nvim-tree/nvim-web-devicons',     -- optional
    }
}
