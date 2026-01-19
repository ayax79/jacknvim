return
{
    "rmehri01/onenord.nvim",
    enabled = vim.g.theme_name == "onenord",
    priority = 1000,
    config = function()
        require("onenord").setup({
            fade_nc = true,
        })
    end,
}
