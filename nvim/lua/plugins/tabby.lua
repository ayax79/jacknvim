return {
    'nanozuki/tabby.nvim',
    config = function()
        require('tabby').setup({
            preset = 'active_wins_at_tail',
            option = {
                nerdfont = true,  -- whether use nerdfont
                lualine_theme = 'auto',
                tab_name = {
                    name_fallback = function(tabid)
                        return tabid
                    end,
                },
                buf_name = {
                    mode = 'unique', -- or 'relative', 'tail', 'shorten'
                },
            },
        })
    end,
}
