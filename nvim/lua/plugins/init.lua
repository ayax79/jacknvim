M = {}

table.insert(M, {
    "nvim-lua/plenary.nvim",
    -- require("plugins/fidget"),
    -- require("plugins/image"),
    -- require("plugins/nvim_java"),
    require("plugins.mini"),
    require("plugins/avante"),
    require("plugins/blink"),
    require("plugins/bufferline"),
    require("plugins/colorizer"),
    require("plugins/copilot"),
    require("plugins/crates"),
    require("plugins/dap"),
    require("plugins/gitsigns"),
    require("plugins/go"),
    require("plugins/lazydev"),
    require("plugins/lspconfig"),
    require("plugins/lspsaga"),
    require("plugins/lualine"),
    require("plugins/menu"),
    require("plugins/molten"),
    require("plugins/multicursor"),
    require("plugins/neoconf"),
    require("plugins/neotest"),
    require("plugins/noice"),
    require("plugins/nord"),
    require("plugins/nvim_coverage"),
    require("plugins/nvim_metals"),
    require("plugins/oil"),
    -- require("plugins/onenord"),
    require("plugins/rustaceanvim"),
    require("plugins/snacks"),
    require("plugins/treesitter"),
    require("plugins/trouble"),
    require("plugins/ts_comments"),
    require("plugins/unimpaired"),
    require("plugins/whichkey"),
    require("plugins/yazi"),

    -- handy keybindings
    { "tpope/vim-fugitive",        lazy = false },
    -- { "f-person/git-blame.nvim", lazy = false },
    -- ---------------------------------------------------------
    --- COMPLETIONS SUPPORT
    --------------------------------------------------------

    -- github copilot
    -- "onsails/lspkind.nvim",
    --------------------------------------------------------
    --- LSP SUPPORT
    --------------------------------------------------------

    -- {
    --     "SmiteshP/nvim-navic",
    --     requires = "neovim/nvim-lspconfig"
    -- },
    -- -- configures lsp and debugger for rust
    -- fork of null-ls
    "nvimtools/none-ls.nvim",
    "folke/lsp-colors.nvim",
    -- json/yaml schema stores
    "b0o/SchemaStore.nvim",
})

return M
