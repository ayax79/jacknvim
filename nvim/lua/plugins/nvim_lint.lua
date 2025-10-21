return {
    "mfussenegger/nvim-lint",
    opts = {
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        linters_by_ft = {
            fish = { "fish" },
            markdown = { "markdownlint-cli2", "cspell" },
        },
    },
    config = function(_, opts)
        local lint = require("lint")
        lint.linters_by_ft = opts.linters_by_ft
        vim.api.nvim_create_autocmd(opts.events, {
            group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
            callback = function()
                require("lint").try_lint()
            end
        })
        lint.linters.cspell = require("lint.util").wrap(lint.linters.cspell, function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
            return diagnostic
        end)
    end,
}
