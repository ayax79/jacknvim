return
{
    "gbprod/nord.nvim",
    enabled = false,
    priority = 1000,
    config = function()
        require("nord").setup({
            transparent = true,
        })
    end,
}
