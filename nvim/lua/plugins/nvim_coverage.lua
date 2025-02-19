return {
    "andythigpen/nvim-coverage",
    ft = "rust",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("coverage").setup()
    end,
}
