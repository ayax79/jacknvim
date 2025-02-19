M = {}

table.insert(M, {
    "nvim-lua/plenary.nvim",
    -- Theme
    require("plugins/onenord"),
    -- Bottom line
    require("plugins/lualine"),
    require("plugins/treesitter"),
    require("plugins/snacks"),
    require("plugins/whichkey"),
    require("plugins/lspsaga"),
    require("plugins/mini_pairs"),
    -- handy keybindings
    {
        'tummetott/unimpaired.nvim',
        event = 'VeryLazy',
        opts = {
            -- add options here if you wish to override the default settings
        },
    },
    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    },
    ---------------------------------------------------------
    --- GIT SUPPORT
    --------------------------------------------------------

    -- Shows git status in the left gutter
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = 'Next uncommitted change' })

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = 'Previous uncommitted change' })

                    -- Actions
                    -- map('n', '<leader>gs', gs.stage_hunk, { desc = 'State Hunk' })
                    map('n', '<leader>gr', gs.reset_hunk, { desc = 'Reset Hunk' })
                    map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        { desc = 'State Hunk' })
                    map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        { desc = 'Reset Hunk' })
                    -- map('n', '<leader>gS', gs.stage_buffer, { desc = 'State Buffer' })
                    map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo State Hunk' })
                    map('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset Buffer' })
                    map('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview Hunk' })
                    map('n', '<leader>gb', function() gs.blame_line { full = true } end, { desc = 'Blame Line' })
                    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle Current Line Blame' })
                    -- map('n', '<leader>gd', gs.diffthis, { desc = 'Diff this' })
                    map('n', '<leader>gD', function() gs.diffthis('~') end, { desc = 'Diff this ~' })
                    map('n', '<leader>td', gs.toggle_deleted, { desc = 'Toggle Deleted' })

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Git Signs Select Hunk' })
                end
            })
        end,
    },
    -- Git wrapper
    { "tpope/vim-fugitive",   lazy = false },
    -- { "f-person/git-blame.nvim", lazy = false },
    -- ---------------------------------------------------------
    --- COMPLETIONS SUPPORT
    --------------------------------------------------------

    {
        'saghen/blink.cmp',
        lazy = false, -- lazy loading handled internally
        -- optional: provides snippets for the snippet source
        dependencies = 'rafamadriz/friendly-snippets',

        -- use a release tag to download pre-built binaries
        version = 'v0.*',
        -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- see the "default configuration" section below for full documentation on how to define
            -- your own keymap.
            keymap = {
                preset = 'default',
                -- ['<CR>'] = { 'accept', 'fallback' },
            },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, via `opts_extend`
            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                    -- copilot = {
                    --     name = "copilot",
                    --     module = "blink-cmp-copilot",
                    --     score_offset = 100,
                    --     async = true,
                    -- },
                },
            },

            -- experimental auto-brackets support
            completion = { accept = { auto_brackets = { enabled = true } } }

            -- experimental signature help support
            -- signature = { enabled = true }
        },
        -- allows extending the enabled_providers array elsewhere in your config
        -- without having to redefine it
        opts_extend = { "sources.default" },

        menu = {
            -- Reverse the direction priority in order to not conflict with copilot
            direction_priority = { 'n', 's' },
            draw = {
                treesitter = { "lsp" },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },
        ghost_text = {
            enabled = vim.g.ai_cmp,
        },
    },
    -- github copilot
    -- "giuxtaposition/blink-cmp-copilot",
    -- {
    --     "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     event = "InsertEnter",
    --     config = function()
    --         require("copilot").setup({
    --             -- suggestion = { enabled = false },
    --             -- panel = { enabled = false },
    --         })
    --     end,
    -- },
    -- -- {
    --     "yetone/avante.nvim",
    --     event = "VeryLazy",
    --     lazy = false,
    --     version = false, -- set this if you want to always pull the latest change
    --     opts = {},
    --     -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    --     build = "make",
    --     dependencies = {
    --         "stevearc/dressing.nvim",
    --         "nvim-lua/plenary.nvim",
    --         "MunifTanjim/nui.nvim",
    --         --- The below dependencies are optional,
    --         "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    --         "zbirenbaum/copilot.lua",      -- for providers='copilot'
    --         {
    --             -- support for image pasting
    --             "HakonHarnes/img-clip.nvim",
    --             event = "VeryLazy",
    --             opts = {
    --                 -- recommended settings
    --                 default = {
    --                     embed_image_as_base64 = false,
    --                     prompt_for_file_name = false,
    --                     drag_and_drop = {
    --                         insert_mode = true,
    --                     },
    --                     -- required for Windows users
    --                     use_absolute_path = true,
    --                 },
    --             },
    --         },
    --         {
    --             -- Make sure to set this up properly if you have lazy=true
    --             'MeanderingProgrammer/render-markdown.nvim',
    --             opts = {
    --                 file_types = { "markdown", "Avante" },
    --             },
    --             ft = { "markdown", "Avante" },
    --         },
    --     },
    -- },
    -- "onsails/lspkind.nvim",
    --------------------------------------------------------
    --- LSP SUPPORT
    --------------------------------------------------------

    -- LSP configuration
    {
        "folke/neoconf.nvim",
        config = true,
        priority = 900,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            "SmiteshP/nvim-navbuddy",
        }
    },
    {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig"
    },
    -- provides the underlying debugger support
    "mfussenegger/nvim-dap",
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup()
        end
    },
    -- debugger ui
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
    },
    -- configures lsp and debugger for rust
    {
        'mrcjkb/rustaceanvim',
        version = '^5',
        lazy = false,
    },
    {
        "ray-x/go.nvim",
        lazy = false,
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    -- fork of null-ls
    "nvimtools/none-ls.nvim",
    {
        'saecki/crates.nvim',
        tag = 'stable',
        config = function()
            require('crates').setup()
        end,
    },
    -- LSP support neovim development
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    -- Line indentation
    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     main = "ibl",
    --     ---@module "ibl"
    --     ---@type ibl.config
    --     opts = {},
    --     config = true,
    -- },
    -- colors for lsp diagnostics
    { "folke/lsp-colors.nvim" },
    -- Java LSP support
    {
        'nvim-java/nvim-java',
        dependencies = {
            'nvim-java/lua-async-await',
            'nvim-java/nvim-java-refactor',
            'nvim-java/nvim-java-core',
            'nvim-java/nvim-java-test',
            'nvim-java/nvim-java-dap',
            'MunifTanjim/nui.nvim',
            'neovim/nvim-lspconfig',
            'mfussenegger/nvim-dap',
            --     {
            --         'williamboman/mason.nvim',
            --         opts = {
            --             registries = {
            --                 'github:nvim-java/mason-registry',
            --                 'github:mason-org/mason-registry',
            --             },
            --         },
            --     }
        },
    },
    {
        "scalameta/nvim-metals",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "mfussenegger/nvim-dap",
                config = function()
                    -- Debug settings if you're using nvim-dap
                    local dap = require("dap")

                    dap.configurations.scala = {
                        {
                            type = "scala",
                            request = "launch",
                            name = "RunOrTest",
                            metals = {
                                runType = "runOrTestFile",
                                --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
                            },
                        },
                        {
                            type = "scala",
                            request = "launch",
                            name = "Test Target",
                            metals = {
                                runType = "testTarget",
                            },
                        },
                    }
                end
            },
        },
        ft = { "scala", "sbt" },
    },
    -- json/yaml schema stores
    "b0o/SchemaStore.nvim",
    {
        "andythigpen/nvim-coverage",
        ft = "rust",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("coverage").setup()
        end,
    },
    -- {
    --     "ThePrimeagen/harpoon",
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     branch = "harpoon2",
    --     config = true,
    -- },
    -- {
    --     "norcalli/nvim-colorizer.lua",
    --     lazy = false,
    --     config = function() require("colorizer").setup() end,
    -- },
    -- file manager
    {
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
    },
    {
        "refractalize/oil-git-status.nvim",
        dependencies = {
            "stevearc/oil.nvim",
        },
        config = true,
    },
    -- Extra power search and replace
    {
        "tpope/vim-abolish",
        lazy = false,
    },
    -- using mason for installing packages that are broken in nix.
    -- Looking at you vscode-lldb.
    -- "williamboman/mason.nvim",
    -- "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    -- "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- LSP status, etc
    {
        "j-hui/fidget.nvim",
        lazy = false,
        version = "1",
        config = true,
    },
    -- tab line
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { 'close' },
                },
            }
        },
    },
    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        config = function()
            local mc = require("multicursor-nvim")

            mc.setup()

            local set = vim.keymap.set

            -- Add or skip cursor above/below the main cursor.
            set({ "n", "v" }, "<up>",
                function() mc.lineAddCursor(-1) end)
            set({ "n", "v" }, "<down>",
                function() mc.lineAddCursor(1) end)
            set({ "n", "v" }, "<leader><up>",
                function() mc.lineSkipCursor(-1) end)
            set({ "n", "v" }, "<leader><down>",
                function() mc.lineSkipCursor(1) end)

            -- Add or skip adding a new cursor by matching word/selection
            set({ "n", "v" }, "<leader>n",
                function() mc.matchAddCursor(1) end)
            set({ "n", "v" }, "<leader>s",
                function() mc.matchSkipCursor(1) end)
            set({ "n", "v" }, "<leader>N",
                function() mc.matchAddCursor(-1) end)
            set({ "n", "v" }, "<leader>S",
                function() mc.matchSkipCursor(-1) end)

            -- Add all matches in the document
            set({ "n", "v" }, "<leader>A", mc.matchAllAddCursors)

            -- You can also add cursors with any motion you prefer:
            -- set("n", "<right>", function()
            --     mc.addCursor("w")
            -- end)
            -- set("n", "<leader><right>", function()
            --     mc.skipCursor("w")
            -- end)

            -- Rotate the main cursor.
            set({ "n", "v" }, "<left>", mc.nextCursor)
            set({ "n", "v" }, "<right>", mc.prevCursor)

            -- Delete the main cursor.
            set({ "n", "v" }, "<leader>x", mc.deleteCursor)

            -- Add and remove cursors with control + left click.
            set("n", "<c-leftmouse>", mc.handleMouse)

            -- Easy way to add and remove cursors using the main cursor.
            set({ "n", "v" }, "<c-q>", mc.toggleCursor)

            -- Clone every cursor and disable the originals.
            set({ "n", "v" }, "<leader><c-q>", mc.duplicateCursors)

            set("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                elseif mc.hasCursors() then
                    mc.clearCursors()
                else
                    -- Default <esc> handler.
                end
            end)

            -- bring back cursors if you accidentally clear them
            set("n", "<leader>gv", mc.restoreCursors)

            -- Align cursor columns.
            set("v", "<leader>a", mc.alignCursors)

            -- Split visual selections by regex.
            set("v", "S", mc.splitCursors)

            -- Append/insert for each line of visual selections.
            set("v", "I", mc.insertVisual)
            set("v", "A", mc.appendVisual)

            -- match new cursors within visual selections by regex.
            set("v", "M", mc.matchCursors)

            -- Rotate visual selection contents.
            set("v", "<leader>t",
                function() mc.transposeCursors(1) end)
            set("v", "<leader>T",
                function() mc.transposeCursors(-1) end)

            -- Jumplist support
            set({ "v", "n" }, "<c-i>", mc.jumpForward)
            set({ "v", "n" }, "<c-o>", mc.jumpBackward)

            -- Customize how cursors look.
            local hl = vim.api.nvim_set_hl
            hl(0, "MultiCursorCursor", { link = "Cursor" })
            hl(0, "MultiCursorVisual", { link = "Visual" })
            hl(0, "MultiCursorSign", { link = "SignColumn" })
            hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
            hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
            hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    ---@type LazySpec
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                "<leader>-",
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
                -- Open in the current working directory
                "<leader>cw",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory",
            },
            {
                -- NOTE: this requires a version of yazi that includes
                -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
                '<c-up>',
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
        -- ---@type YaziConfig
        -- opts = {
        --     -- if you want to open yazi instead of netrw, see below for more info
        --     open_for_directories = false,
        --     keymaps = {
        --         show_help = '<f1>',
        --     },
        -- },
    },
    -- {
    --     "Canop/nvim-bacon",
    --     config = function()
    --         require("bacon").setup({
    --             quickfix = {
    --                 enabled = true,       -- Enable Quickfix integration
    --                 event_trigger = true, -- Trigger QuickFixCmdPost after populating Quickfix list
    --             },
    --         })
    --     end,
    -- },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter"
        },
        config = function()
            require('neotest').setup {
                adapters = {
                    require('rustaceanvim.neotest')
                },
            }
        end
    },
    -- {
    --     'echasnovski/mini.ai',
    --     version = '*',
    --     opts = function()
    --         local ai = require("mini.ai")
    --         return {
    --             n_lines = 500,
    --             custom_textobjects = {
    --                 o = ai.gen_spec.treesitter({ -- code block
    --                     a = { "@block.outer", "@conditional.outer", "@loop.outer" },
    --                     i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    --                 }),
    --                 f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
    --                 c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),       -- class
    --                 t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },           -- tags
    --                 d = { "%f[%d]%d+" },                                                          -- digits
    --                 e = {                                                                         -- Word with case
    --                     { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
    --                     "^().*()$",
    --                 },
    --                 u = ai.gen_spec.function_call(),                           -- u for "Usage"
    --                 U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
    --             },
    --         }
    --     end
    -- },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
--     {
--         'alexghergh/nvim-tmux-navigation',
--         config = function()
--             local nvim_tmux_nav = require('nvim-tmux-navigation')
--
--             nvim_tmux_nav.setup {
--                 disable_when_zoomed = true -- defaults to false
--             }
--
--             vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
--             vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
--             vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
--             vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
--             vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
--             vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
--         end
--     },
})

return M
