-- Paint a slightly different background behind treesitter-injected languages
-- (e.g. bash/zsh/nu inside Nix strings). Uses ephemeral extmarks from a
-- decoration provider, so it always tracks the current parse with no state.
local M = {}

local ns = vim.api.nvim_create_namespace("injection_bg")
-- languages to never shade (e.g. comment injections are everywhere)
M.ignore = { comment = true, regex = true, luadoc = true, jsdoc = true }
M.amount = 0.06 -- how far to shift the Normal background (0..1)

local function shift(color, amount)
    local r, g, b = bit.rshift(color, 16), bit.band(bit.rshift(color, 8), 0xff), bit.band(color, 0xff)
    local lum = (0.299 * r + 0.587 * g + 0.114 * b) / 255
    local target = lum < 0.5 and 255 or 0 -- lighten dark themes, darken light ones
    local f = function(c) return math.floor(c + (target - c) * amount + 0.5) end
    return string.format("#%02x%02x%02x", f(r), f(g), f(b))
end

function M.set_hl()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
    local bg = normal.bg or (vim.o.background == "dark" and 0x1e1e1e or 0xffffff)
    vim.api.nvim_set_hl(0, "InjectionBg", { bg = shift(bg, M.amount), default = true })
end

local function collect(ltree, acc)
    for lang, child in pairs(ltree:children()) do
        if not M.ignore[lang] then
            for _, tree in pairs(child:trees()) do
                for _, r in ipairs(tree:included_ranges(false)) do
                    acc[#acc + 1] = r
                end
            end
        end
        collect(child, acc)
    end
end

function M.setup(opts)
    opts = opts or {}
    if opts.ignore then M.ignore = opts.ignore end
    if opts.amount then M.amount = opts.amount end

    M.set_hl()
    vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("InjectionBg", { clear = true }),
        callback = function()
            pcall(vim.api.nvim_set_hl, 0, "InjectionBg", {}) -- reset so default=true re-applies
            M.set_hl()
        end,
    })

    vim.api.nvim_set_decoration_provider(ns, {
        on_win = function(_, _, buf, top, bot)
            if not vim.treesitter.highlighter.active[buf] then return false end
            local ok, parser = pcall(vim.treesitter.get_parser, buf)
            if not ok or not parser then return false end
            local ranges = {}
            collect(parser, ranges)
            for _, r in ipairs(ranges) do
                local sr, sc, er, ec = r[1], r[2], r[3], r[4]
                if er >= top and sr <= bot then
                    pcall(vim.api.nvim_buf_set_extmark, buf, ns, sr, sc, {
                        end_row = er,
                        end_col = ec,
                        hl_group = "InjectionBg",
                        hl_eol = true,
                        priority = 10, -- below treesitter so syntax colors still win
                        ephemeral = true,
                    })
                end
            end
            return false
        end,
    })
end

return M
