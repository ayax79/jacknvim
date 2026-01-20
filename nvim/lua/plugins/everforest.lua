return
-- {
--     "neanias/everforest-nvim",
--     enabled = vim.g.theme_name == "everforest",
--     version = false,
--     lazy = false,
--     priority = 1000, -- make sure to load this before all the other start plugins
--     -- Optional; default configuration will be used if setup isn't called.
--     config = function()
--         require("everforest").setup({
--             -- Your config here
--         })
--     end,
-- }
{
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        -- vim.g.everforest_enable_italic = true
        vim.cmd.colorscheme('everforest')
        vim.g.everforest_background = 'hard'
        vim.g.everforest_better_performance = 1
    end
}
