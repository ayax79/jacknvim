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
    require("plugins.mini"),
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
    require("plugins/molten"),
    require("plugins/lazydev"),
    require("plugins/neoconf"),
    require("plugins/lspconfig"),
    require("plugins/dap"),
    require("plugins/crates"),
    require("plugins/fidget"),
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

    {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig"
    },
    -- configures lsp and debugger for rust
    {
        'mrcjkb/rustaceanvim',
        version = '^5',
        lazy = true,
    },
    -- fork of null-ls
    "nvimtools/none-ls.nvim",
    "folke/lsp-colors.nvim",
    -- json/yaml schema stores
    "b0o/SchemaStore.nvim",
})

return M
