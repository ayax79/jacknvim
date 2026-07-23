-- Colorscheme setup (eager - must be available for vim.cmd.colorscheme)
local theme_name = vim.g.theme_name

if string.find(theme_name, "kanagawa") then
    local theme
    if string.find(theme_name, "lotus") then
        theme = "lotus"
    elseif string.find(theme_name, "dragon") then
        theme = "dragon"
    else
        theme = "wave"
    end

    local dark = string.find(theme_name, "dragon") and "dragon" or "wave"

    require("kanagawa").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true,
        dimInactive = true,
        terminalColors = true,
        colors = {
            palette = {},
            theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors)
            local t = colors.theme
            local makeDiagnosticColor = function(color)
                local c = require("kanagawa.lib.color")
                return { fg = color, bg = c(color):blend(t.ui.bg, 0.95):to_hex() }
            end
            return {
                Pmenu = { fg = t.ui.shade0, bg = t.ui.bg_p1 },
                PmenuSel = { fg = "NONE", bg = t.ui.bg_p2 },
                PmenuSbar = { bg = t.ui.bg_m1 },
                PmenuThumb = { bg = t.ui.bg_p2 },
                DiagnosticVirtualTextHint = makeDiagnosticColor(t.diag.hint),
                DiagnosticVirtualTextInfo = makeDiagnosticColor(t.diag.info),
                DiagnosticVirtualTextWarn = makeDiagnosticColor(t.diag.warning),
                DiagnosticVirtualTextError = makeDiagnosticColor(t.diag.error),
                SnacksDashboardHeader = { fg = t.vcs.removed },
                SnacksDashboardFooter = { fg = t.syn.comment },
                SnacksDashboardDesc = { fg = t.syn.identifier },
                SnacksDashboardIcon = { fg = t.ui.special },
                SnacksDashboardKey = { fg = t.syn.special1 },
                SnacksDashboardSpecial = { fg = t.syn.comment },
                SnacksDashboardDir = { fg = t.syn.identifier },
                SnacksNotifierBorderError = { link = "DiagnosticError" },
                SnacksNotifierBorderWarn = { link = "DiagnosticWarn" },
                SnacksNotifierBorderInfo = { link = "DiagnosticInfo" },
                SnacksNotifierBorderDebug = { link = "Debug" },
                SnacksNotifierBorderTrace = { link = "Comment" },
                SnacksNotifierIconError = { link = "DiagnosticError" },
                SnacksNotifierIconWarn = { link = "DiagnosticWarn" },
                SnacksNotifierIconInfo = { link = "DiagnosticInfo" },
                SnacksNotifierIconDebug = { link = "Debug" },
                SnacksNotifierIconTrace = { link = "Comment" },
                SnacksNotifierTitleError = { link = "DiagnosticError" },
                SnacksNotifierTitleWarn = { link = "DiagnosticWarn" },
                SnacksNotifierTitleInfo = { link = "DiagnosticInfo" },
                SnacksNotifierTitleDebug = { link = "Debug" },
                SnacksNotifierTitleTrace = { link = "Comment" },
                SnacksNotifierError = { link = "DiagnosticError" },
                SnacksNotifierWarn = { link = "DiagnosticWarn" },
                SnacksNotifierInfo = { link = "DiagnosticInfo" },
                SnacksNotifierDebug = { link = "Debug" },
                SnacksNotifierTrace = { link = "Comment" },
                SnacksProfilerIconInfo = { bg = t.ui.bg_search, fg = t.syn.fun },
                SnacksProfilerBadgeInfo = { bg = t.ui.bg_visual, fg = t.syn.fun },
                SnacksScratchKey = { link = "SnacksProfilerIconInfo" },
                SnacksScratchDesc = { link = "SnacksProfilerBadgeInfo" },
                SnacksProfilerIconTrace = { bg = t.syn.fun, fg = t.ui.float.fg_border },
                SnacksProfilerBadgeTrace = { bg = t.syn.fun, fg = t.ui.float.fg_border },
                SnacksIndent = { fg = t.ui.bg_p2, nocombine = true },
                SnacksIndentScope = { fg = t.ui.pmenu.bg, nocombine = true },
                SnacksZenIcon = { fg = t.syn.statement },
                SnacksInputIcon = { fg = t.ui.pmenu.bg },
                SnacksInputBorder = { fg = t.syn.identifier },
                SnacksInputTitle = { fg = t.syn.identifier },
                SnacksPickerInputBorder = { fg = t.syn.constant },
                SnacksPickerInputTitle = { fg = t.syn.constant },
                SnacksPickerBoxTitle = { fg = t.syn.constant },
                SnacksPickerSelected = { fg = t.syn.number },
                SnacksPickerToggle = { link = "SnacksProfilerBadgeInfo" },
                SnacksPickerPickWinCurrent = { fg = t.ui.fg, bg = t.syn.number, bold = true },
                SnacksPickerPickWin = { fg = t.ui.fg, bg = t.ui.bg_search, bold = true },
            }
        end,
        theme = theme,
        background = { dark = dark, light = "lotus" },
    })
elseif theme_name == "everforest" then
    vim.g.everforest_background = 'hard'
    vim.g.everforest_better_performance = 1
elseif theme_name == "nord" then
    require("nord").setup({ transparent = true })
elseif theme_name == "onedark" then
    require('onedark').setup({
        style = 'darker',
        transparent = 'true'
    })
    require('onedark').load()
elseif string.find(theme_name, "catppuccin") then
    require("catppuccin").setup({
        auto_integrations = true,
    })
elseif theme_name == "oxocarbon" then
    -- The following allows for a transparent background
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
elseif theme_name == "onenord" then
    require("onenord").setup({ fade_nc = true })
end
vim.cmd.colorscheme(vim.g.theme_name)
