return {
    "azorng/goose.nvim",
    config = function()
        require("goose").setup({
            preferred_picker = "snacks",
        })
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                anti_conceal = { enabled = false },
            },
        }
    },
}
