return {
    'stevearc/oil.nvim',
    opts = function()
        local detail = false;
        return {
            win_options = {
                signcolumn = "yes:2",
            },
            view_options = {
                show_hidden = true,
            },
            keymaps = {
                -- The following two keymaps conflict with vim tmux navigation
                -- so I disabled them
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["F8"] = "actions.refresh",
                ["gi"] = {
                    desc = "Toggle file detail view",
                    callback = function()
                        detail = not detail
                        if detail then
                            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                        else
                            require("oil").set_columns({ "icon" })
                        end
                    end,
                }
            }
        }
    end,
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
