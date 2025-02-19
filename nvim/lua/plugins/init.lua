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
    require("plugins/gitsigns"),
    require("plugins/blink"),
    require("plugins/trouble"),
    require("plugins/multicursor"),
    require("plugins/yazi"),
    require("plugins/bufferline"),
    require("plugins/oil"),
    require("plugins/neotest"),
    require("plugins/nvim_metals"),
    require("plugins/nvim_java"),
    require("plugins/go"),
    require("plugins/nvim_coverage"),
    require("plugins/unimpaired"),
    require("plugins/ts_comments"),
    require("plugins/image"),
    --require("plugins/avante")
    -- handy keybindings
    { "tpope/vim-fugitive",        lazy = false },
    -- { "f-person/git-blame.nvim", lazy = false },
    -- ---------------------------------------------------------
    --- COMPLETIONS SUPPORT
    --------------------------------------------------------

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
        lazy = true,
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
    "folke/lsp-colors.nvim",
    -- json/yaml schema stores
    "b0o/SchemaStore.nvim",
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
        "refractalize/oil-git-status.nvim",
        dependencies = {
            "stevearc/oil.nvim",
        },
        config = true,
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
    { 'echasnovski/mini.surround', version = '*' },
    -- {
    --     "kylechui/nvim-surround",
    --     version = "*", -- Use for stability; omit to use `main` branch for the latest features
    --     event = "VeryLazy",
    --     config = function()
    --         require("nvim-surround").setup({
    --             -- Configuration here, or leave empty to use defaults
    --         })
    --     end
    -- },
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
