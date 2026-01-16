return
{
    "rmehri01/onenord.nvim",
    enabled = vim.g.theme_name == "nord",
    priority = 1000,
    config = function()
        require("onenord").setup({
            transparent = true,
        })
    end,
}
-- {
--     "gbprod/nord.nvim",
--     enabled = vim.g.theme_name == "nord",
--     priority = 1000,
--     config = function()
--         require("nord").setup({
--             transparent = true,
--         })
--     end,
-- }
