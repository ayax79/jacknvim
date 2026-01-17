return {
    "ThePrimeagen/harpoon",
    enabled = false,
    keys = function()
        local harpoon = require("harpoon")
        return {
            {
                "<leader>a",
                function()
                    harpoon:list():add()
                end,
                desc = "Harpoon add file",
            },
            {
                "<C-e>",
                function()
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Harpoon toggle menu",
            },
            {
                "<C-h>",
                function()
                    harpoon:list():select(1)
                end,
                desc = "Harpoon select 1",
            },
            {
                "<C-t>",
                function()
                    harpoon:list():select(2)
                end,
                desc = "Harpoon select 2",
            },
            {
                "<C-n>",
                function()
                    harpoon:list():select(3)
                end,
                desc = "Harpoon select 3",
            },
            {
                "<C-s>",
                function()
                    harpoon:list():select(4)
                end,
                desc = "Harpoon select 4",
            },
            {
                "<C-S-P>",
                function()
                    harpoon:list():prev()
                end,
                desc = "Harpoon prev",
            },
            {
                "<C-S-N>",
                function()
                    harpoon:list():next()
                end,
                desc = "Harpoon next",
            },
        }
    end,
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
}
