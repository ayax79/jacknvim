return {
    "github/copilot.vim",
    config = function()
        vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
            expr = true,
            replace_keycodes = false
        })
        vim.g.copilot_no_tab_map = true
    end
}
-- {
--     "giuxtaposition/blink-cmp-copilot",
--     {
--         "zbirenbaum/copilot.lua",
--         cmd = "Copilot",
--         event = "InsertEnter",
--         config = function()
--             require("copilot").setup({
--                 suggestion = { enabled = true },
--                 panel = { enabled = true },
--             })
--         end,
--     },
-- };
