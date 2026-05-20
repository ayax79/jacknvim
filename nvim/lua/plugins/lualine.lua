return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    enabled = true,
    opts = function()
        local opts = {
            options = {
                icons_enabled = true,
                -- theme = vim.g.theme_name,
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    -- tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = {
                    {
                        'filename',
                        file_status = true,
                        path = 1,
                        shortening_target = 40,
                    }
                },
                -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_x = {
                    -- {
                    --     require("noice").api.status.message.get_hl,
                    --     cond = require("noice").api.status.message.has,
                    -- },
                    -- {
                    --      require("noice").api.status.command.get,
                    --      cond = require("noice").api.status.command.has,
                    --      color = { fg = "#d08770" },
                    --  },
                    {
                        'lsp_status',
                        icon = '', -- f013
                        symbols = {
                            -- Standard unicode symbols to cycle through for LSP progress:
                            spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                            -- Standard unicode symbol for when LSP is done:
                            done = '✓',
                            -- Delimiter inserted between LSP names:
                            separator = ' ',
                        },
                        -- List of LSP names to ignore (e.g., `null-ls`):
                        ignore_lsp = { "copilot" },
                        -- Display the LSP name
                        show_name = true,
                    },
                    -- {
                    --     require("noice").api.status.mode.get,
                    --     cond = require("noice").api.status.mode.has,
                    --     color = { fg = "#d08770" },
                    -- },
                    -- {
                    --     require("noice").api.status.search.get,
                    --     cond = require("noice").api.status.search.has,
                    --     color = { fg = "#d08770" },
                    -- },
                    'filetype',
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {
                -- lualine_a = {},
                -- lualine_b = {},
                -- lualine_c = {
                --     -- {
                --     --     "filename",
                --     --     file_status = true,
                --     --     new_file_status = true,
                --     --     path = 3,
                --     --     shorting_target = 40,
                --     -- },
                -- },
                -- lualine_x = {},
                -- lualine_y = {},
                -- lualine_z = {}
            },
            winbar = {},
            inactive_winbar = {},
            extensions = {
                "avante",
                "fzf",
                "lazy",
                "oil",
                "trouble",
                "quickfix",
            },
        }
        -- local trouble = require("trouble")
        -- local symbols = trouble.statusline({
        --     mode = "lsp_document_symbols",
        --     groups = {},
        --     title = false,
        --     filter = { range = true },
        --     format = "{kind_icon}{symbol.name:Normal}",
        --     -- The following line is needed to fix the background color
        --     -- Set it to the lualine section you want to use
        --     hl_group = "lualine_c_normal",
        -- })
        -- table.insert(opts.sections.lualine_c, {
        --     symbols.get,
        --     cond = symbols.has,
        -- })
        return opts
    end,
}
