return {
    "nvim-neotest/neotest",
    -- disabling because of slow load time
    enabled = true,
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter"
    },
    config = function()
        require('neotest').setup {
            adapters = {
                require('rustaceanvim.neotest')
            },
        }
    end
}
