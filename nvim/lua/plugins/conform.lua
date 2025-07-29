return -- lazy.nvim setup
{
    "stevearc/conform.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>lf", function() require("conform").format() end, desc = "Format" },
    },
    opts = {
        formatters_by_ft = {
            nu = { "topiary_nu" },
            markdown = { "dprint" },
            toml = { "dprint" },
        },
        formatters = {
            topiary_nu = {
                command = "topiary",
                args = { "format", "--language", "nu" },
            },
        },
        default_format_opts = {
            async = true,
            lsp_format = "fallback",
            timeout_ms = 10000,
        },
    },
}
