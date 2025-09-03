return {
    -- "github/copilot.vim",
    -- config = function()
    --     vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
    --         expr = true,
    --         replace_keycodes = false
    --     })
    --     vim.g.copilot_no_tab_map = true
    -- end
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        keys = {
            { "<C-J>", function() require("copilot.suggestion").accept() end,  mode = "i", desc = "Accept Copilot suggestion" },
            { "<C-K>", function() require("copilot.suggestion").dismiss() end, mode = "i", desc = "Dismiss Copilot suggestion" },
            { "<C-H>", function() require("copilot.suggestion").prev() end,    mode = "i", desc = "Previous Suggestion" },
            { "<C-L>", function() require("copilot.suggestion").next() end,    mode = "i", desc = "Next Suggestion" },
        },
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                },
                panel = { enabled = true },
                model = "claude-sonnet-4",
            })
        end,
    },
}
