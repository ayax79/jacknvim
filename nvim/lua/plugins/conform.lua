return -- lazy.nvim setup
{
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {
        formatters_by_ft = {
            nu = { "topiary_nu" },
        },
        formatters = {
            topiary_nu = {
                command = "topiary",
                args = { "format", "--language", "nu" },
            },
        },
    },
}
