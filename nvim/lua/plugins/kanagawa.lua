local theme;
if string.find(vim.g.theme_name, "lotus")
then
    theme = "lotus"
elseif string.find(vim.g.theme_name, "dragon")
then
    theme = "dragon"
else
    theme = "wave"
end

local dark;
if string.find(vim.g.theme_name, "dragon")
then
    theme = "dragon"
else
    theme = "wave"
end

return {
    "rebelot/kanagawa.nvim",
    enabled = string.find(vim.g.theme_name, "kanagawa") ~= nil,
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
                -- SnacksDashboard
                SnacksDashboardHeader      = { fg = theme.vcs.removed },
                SnacksDashboardFooter      = { fg = theme.syn.comment },
                SnacksDashboardDesc        = { fg = theme.syn.identifier },
                SnacksDashboardIcon        = { fg = theme.ui.special },
                SnacksDashboardKey         = { fg = theme.syn.special1 },
                SnacksDashboardSpecial     = { fg = theme.syn.comment },
                SnacksDashboardDir         = { fg = theme.syn.identifier },
                -- SnacksNotifier
                SnacksNotifierBorderError  = { link = "DiagnosticError" },
                SnacksNotifierBorderWarn   = { link = "DiagnosticWarn" },
                SnacksNotifierBorderInfo   = { link = "DiagnosticInfo" },
                SnacksNotifierBorderDebug  = { link = "Debug" },
                SnacksNotifierBorderTrace  = { link = "Comment" },
                SnacksNotifierIconError    = { link = "DiagnosticError" },
                SnacksNotifierIconWarn     = { link = "DiagnosticWarn" },
                SnacksNotifierIconInfo     = { link = "DiagnosticInfo" },
                SnacksNotifierIconDebug    = { link = "Debug" },
                SnacksNotifierIconTrace    = { link = "Comment" },
                SnacksNotifierTitleError   = { link = "DiagnosticError" },
                SnacksNotifierTitleWarn    = { link = "DiagnosticWarn" },
                SnacksNotifierTitleInfo    = { link = "DiagnosticInfo" },
                SnacksNotifierTitleDebug   = { link = "Debug" },
                SnacksNotifierTitleTrace   = { link = "Comment" },
                SnacksNotifierError        = { link = "DiagnosticError" },
                SnacksNotifierWarn         = { link = "DiagnosticWarn" },
                SnacksNotifierInfo         = { link = "DiagnosticInfo" },
                SnacksNotifierDebug        = { link = "Debug" },
                SnacksNotifierTrace        = { link = "Comment" },
                -- SnacksProfiler
                SnacksProfilerIconInfo     = { bg = theme.ui.bg_search, fg = theme.syn.fun },
                SnacksProfilerBadgeInfo    = { bg = theme.ui.bg_visual, fg = theme.syn.fun },
                SnacksScratchKey           = { link = "SnacksProfilerIconInfo" },
                SnacksScratchDesc          = { link = "SnacksProfilerBadgeInfo" },
                SnacksProfilerIconTrace    = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
                SnacksProfilerBadgeTrace   = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
                SnacksIndent               = { fg = theme.ui.bg_p2, nocombine = true },
                SnacksIndentScope          = { fg = theme.ui.pmenu.bg, nocombine = true },
                SnacksZenIcon              = { fg = theme.syn.statement },
                SnacksInputIcon            = { fg = theme.ui.pmenu.bg },
                SnacksInputBorder          = { fg = theme.syn.identifier },
                SnacksInputTitle           = { fg = theme.syn.identifier },
                -- SnacksPicker
                SnacksPickerInputBorder    = { fg = theme.syn.constant },
                SnacksPickerInputTitle     = { fg = theme.syn.constant },
                SnacksPickerBoxTitle       = { fg = theme.syn.constant },
                SnacksPickerSelected       = { fg = theme.syn.number },
                SnacksPickerToggle         = { link = "SnacksProfilerBadgeInfo" },
                SnacksPickerPickWinCurrent = { fg = theme.ui.fg, bg = theme.syn.number, bold = true },
                SnacksPickerPickWin        = { fg = theme.ui.fg, bg = theme.ui.bg_search, bold = true },
            }
        end,
        -- theme = "dragon",    -- Load "wave" theme
        theme = theme,
        background = {   -- map the value of 'background' option to a theme
            dark = dark, -- dragon, wave
            light = "lotus"
        },
    }
}
