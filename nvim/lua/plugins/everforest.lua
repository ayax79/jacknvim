return {
    "neanias/everforest-nvim",
    enabled = vim.g.theme_name == "everforest",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
        require("everforest").setup({
            -- Your config here
        })
    end,
}
