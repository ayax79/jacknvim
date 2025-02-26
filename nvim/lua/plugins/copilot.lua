return {
    "giuxtaposition/blink-cmp-copilot",
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                -- suggestion = { enabled = false },
                -- panel = { enabled = false },
            })
        end,
    },
};
