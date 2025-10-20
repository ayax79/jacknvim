return {
    "rebelot/kanagawa.nvim",
    enabled = vim.g.theme_name == "kanagawa",
    priority = 1000,
    opts = {
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true,   -- do not set background color
        dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {             -- add/modify theme and palette colors
            palette = {},
            theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
            return {}
        end,
        theme = "dragon",    -- Load "wave" theme
        background = {     -- map the value of 'background' option to a theme
            dark = "dragon", -- dragon, wave
            light = "lotus"
        },
    }
}
