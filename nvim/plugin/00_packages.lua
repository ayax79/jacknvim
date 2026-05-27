-- All plugin sources declared in one place.
-- This ensures everything is on the runtime path before any setup runs.
vim.pack.add({
    -- Core / Dependencies
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/nvim-neotest/nvim-nio" },

    -- Colorschemes
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://github.com/catppuccin/nvim" },
    { src = "https://github.com/sainnhe/gruvbox-material" },
    { src = "https://github.com/sainnhe/everforest" },
    { src = "https://github.com/savq/melange-nvim" },
    { src = "https://github.com/gbprod/nord.nvim" },
    { src = "https://github.com/navarasu/onedark.nvim" },
    { src = "https://github.com/rmehri01/onenord.nvim" },

    -- UI
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/nanozuki/tabby.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/folke/trouble.nvim" },
    { src = "https://github.com/j-hui/fidget.nvim" },
    { src = "https://github.com/folke/lsp-colors.nvim" },

    -- Navigation / File management
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/refractalize/oil-git-status.nvim" },
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
    { src = "https://github.com/mikavilpas/yazi.nvim" },

    -- Completion
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
    { src = "https://github.com/rafamadriz/friendly-snippets" },

    -- LSP / Diagnostics
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/b0o/SchemaStore.nvim" },
    { src = "https://github.com/folke/neoconf.nvim" },
    { src = "https://github.com/folke/lazydev.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mfussenegger/nvim-lint" },
    { src = "https://github.com/stevearc/conform.nvim" },

    -- Treesitter
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/nushell/tree-sitter-nu" },
    { src = "https://github.com/folke/ts-comments.nvim" },
    { src = "https://github.com/dariuscorvus/tree-sitter-language-injection.nvim" },

    -- Git
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/akinsho/git-conflict.nvim" },

    -- DAP (Debugging)
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/rcarriga/nvim-dap-ui" },
    { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },

    -- Testing
    { src = "https://github.com/nvim-neotest/neotest" },
    { src = "https://github.com/antoinemadec/FixCursorHold.nvim" },

    -- Language-specific
    { src = "https://github.com/mrcjkb/rustaceanvim" },
    { src = "https://github.com/saecki/crates.nvim" },
    { src = "https://github.com/scalameta/nvim-metals" },
    { src = "https://github.com/mfussenegger/nvim-jdtls" },
    { src = "https://github.com/andythigpen/nvim-coverage" },

    -- AI
    { src = "https://github.com/zbirenbaum/copilot.lua" },
    { src = "https://github.com/yetone/avante.nvim" },
    { src = "https://github.com/HakonHarnes/img-clip.nvim" },

    -- Editing
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/jake-stewart/multicursor.nvim" },
    { src = "https://github.com/tpope/vim-abolish" },
    { src = "https://github.com/nicwest/vim-camelsnek" },

    -- Misc
    { src = "https://github.com/meznaric/key-analyzer.nvim" },
    { src = "https://github.com/kawre/leetcode.nvim" },
})
