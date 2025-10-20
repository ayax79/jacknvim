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
        transparent = true,    -- do not set background color
        dimInactive = true,    -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {             -- add/modify theme and palette colors
            palette = {},
            theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
            local theme = colors.theme
            local makeDiagnosticColor = function(color)
                local c = require("kanagawa.lib.color")
                return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
            end
            return {
                Pmenu                      = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                PmenuSel                   = { fg = "NONE", bg = theme.ui.bg_p2 },
                PmenuSbar                  = { bg = theme.ui.bg_m1 },
                PmenuThumb                 = { bg = theme.ui.bg_p2 },
                DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
                DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
                DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
                DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
            }
        end,
        theme = "dragon",    -- Load "wave" theme
        background = {       -- map the value of 'background' option to a theme
            dark = "dragon", -- dragon, wave
            light = "lotus"
        },
    }
}
