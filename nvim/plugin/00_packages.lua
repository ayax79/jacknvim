-- All plugin sources declared in one place.
-- This ensures everything is on the runtime path before any setup runs.
vim.pack.add({
    -- Core / Dependencies
    { src = "https://github.com/nvim-lua/plenary.nvim" },       -- Lua utility library (async, paths, tests) used as a dependency by many plugins
    { src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- File-type icons (requires a Nerd Font)
    { src = "https://github.com/MunifTanjim/nui.nvim" },        -- UI component library (popups, layouts, inputs) for other plugins
    { src = "https://github.com/nvim-neotest/nvim-nio" },       -- Async I/O library, required by nvim-dap-ui and neotest

    -- Colorschemes
    -- { src = "https://github.com/rebelot/kanagawa.nvim" },
    -- { src = "https://github.com/catppuccin/nvim",                                 name = "catppuccin" },
    -- { src = "https://github.com/nyoom-engineering/oxocarbon.nvim",                   name = "oxocarbon" },
    -- { src = "https://github.com/sainnhe/gruvbox-material" },
    -- { src = "https://github.com/sainnhe/everforest" },
    -- { src = "https://github.com/savq/melange-nvim" },
    -- { src = "https://github.com/gbprod/nord.nvim" },
    { src = "https://github.com/navarasu/onedark.nvim" }, -- Atom One Dark colorscheme with multiple style variants
    -- { src = "https://github.com/rmehri01/onenord.nvim" },

    -- UI
    { src = "https://github.com/folke/snacks.nvim" },         -- Collection of small QoL utilities (dashboard, notifications, picker, terminal)
    { src = "https://github.com/nvim-lualine/lualine.nvim" }, -- Fast and configurable statusline
    { src = "https://github.com/nanozuki/tabby.nvim" },       -- Highly customizable tabline
    { src = "https://github.com/folke/which-key.nvim" },      -- Popup showing available keybindings as you type prefix keys
    { src = "https://github.com/folke/trouble.nvim" },        -- Pretty list for diagnostics, references, quickfix, and location lists
    { src = "https://github.com/j-hui/fidget.nvim" },         -- Non-intrusive LSP progress notifications
    { src = "https://github.com/folke/lsp-colors.nvim" },     -- Adds missing LSP diagnostic highlight groups for colorschemes

    -- Navigation / File management
    { src = "https://github.com/stevearc/oil.nvim" },                -- Edit the filesystem like a buffer (rename, move, delete as text edits)
    { src = "https://github.com/refractalize/oil-git-status.nvim" }, -- Git status indicators for oil.nvim file listings
    { src = "https://github.com/christoomey/vim-tmux-navigator" },   -- Seamless navigation between Neovim splits and tmux panes
    { src = "https://github.com/mikavilpas/yazi.nvim" },             -- Integration with the Yazi terminal file manager

    -- Completion
    { src = "https://github.com/saghen/blink.cmp",                                version = vim.version.range("1.*") }, -- High-performance completion engine with fuzzy matching, written in Rust
    { src = "https://github.com/rafamadriz/friendly-snippets" },                                                        -- Community-maintained collection of VS Code-style snippets

    -- LSP / Diagnostics
    { src = "https://github.com/neovim/nvim-lspconfig" },  -- Official quickstart configs for Neovim's built-in LSP client
    { src = "https://github.com/b0o/SchemaStore.nvim" },   -- SchemaStore catalog for JSON/YAML schema validation in LSP
    { src = "https://github.com/folke/neoconf.nvim" },     -- Per-project LSP settings via .neoconf.json files
    { src = "https://github.com/folke/lazydev.nvim" },     -- Faster LuaLS setup for Neovim plugin/config development
    { src = "https://github.com/mason-org/mason.nvim" },   -- Portable package manager for LSP servers, DAP servers, linters, formatters
    { src = "https://github.com/mfussenegger/nvim-lint" }, -- Asynchronous linter plugin complementing built-in LSP diagnostics
    { src = "https://github.com/stevearc/conform.nvim" },  -- Lightweight formatter with support for multiple formatters in sequence

    -- Treesitter
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },                  -- Treesitter integration for syntax highlighting, indentation, and code understanding
    { src = "https://github.com/nushell/tree-sitter-nu" },                           -- Treesitter grammar for the Nushell scripting language
    -- { src = "https://github.com/folke/ts-comments.nvim" },                           -- Sets correct commentstring per language using treesitter
    { src = "https://github.com/dariuscorvus/tree-sitter-language-injection.nvim" }, -- Custom treesitter language injection rules (e.g., SQL in strings)

    -- Git
    { src = "https://github.com/lewis6991/gitsigns.nvim" },   -- Git diff signs in the sign column, inline blame, and hunk actions
    { src = "https://github.com/tpope/vim-fugitive" },        -- Premier Git wrapper — :Git commands for blame, diff, log, etc.
    { src = "https://github.com/akinsho/git-conflict.nvim" }, -- Visualizes and resolves git merge conflicts with keybindings

    -- DAP (Debugging)
    { src = "https://github.com/mfussenegger/nvim-dap" },           -- Debug Adapter Protocol client for step debugging in the editor
    { src = "https://github.com/rcarriga/nvim-dap-ui" },            -- Full debugging UI (watches, breakpoints, stack, REPL) for nvim-dap
    { src = "https://github.com/theHamsta/nvim-dap-virtual-text" }, -- Shows variable values as virtual text while debugging

    -- Testing
    { src = "https://github.com/nvim-neotest/neotest" }, -- Framework for running and displaying test results with per-language adapters

    -- Language-specific
    { src = "https://github.com/mrcjkb/rustaceanvim" },       -- All-in-one Rust development (rust-analyzer, runnables, debugging)
    { src = "https://github.com/saecki/crates.nvim" },        -- Manage Cargo.toml dependencies — versions, updates, and features
    { src = "https://github.com/scalameta/nvim-metals" },     -- Scala Metals LSP client integration
    { src = "https://github.com/mfussenegger/nvim-jdtls" },   -- Enhanced Java LSP support using Eclipse JDTLS
    { src = "https://github.com/andythigpen/nvim-coverage" }, -- Displays code coverage results as sign column highlights

    -- AI
    { src = "https://github.com/zbirenbaum/copilot.lua" },    -- Pure Lua GitHub Copilot for inline AI code suggestions
    -- { src = "https://github.com/yetone/avante.nvim" },
    { src = "https://github.com/HakonHarnes/img-clip.nvim" }, -- Paste images from clipboard into documents (Markdown, Avante, etc.)

    -- Editing
    { src = "https://github.com/nvim-mini/mini.nvim" },   -- 30+ minimal Lua modules (surround, pairs, align, ai textobjects, etc.)
    -- { src = "https://github.com/jake-stewart/multicursor.nvim" }, -- Multiple cursor support for simultaneous editing
    { src = "https://github.com/tpope/vim-abolish" },     -- Smarter substitution, coercion (camelCase↔snake_case), abbreviations
    { src = "https://github.com/nicwest/vim-camelsnek" }, -- Convert between camelCase, snake_case, kebab-case, etc.

    -- Misc
    { src = "https://github.com/meznaric/key-analyzer.nvim" }, -- Analyzes and visualizes keybinding usage and conflicts
    { src = "https://github.com/kawre/leetcode.nvim" },        -- Solve LeetCode problems directly inside Neovim

    -- Mermaid
    { src = "https://github.com/kevalin/mermaid.nvim" }, -- Preview and render Mermaid diagrams from within Neovim

    { src = "https://github.com/benlubas/molten-nvim",                            version = vim.version.range("1.*") }, -- Molten: juypter notebook integration for Neovim with inline code execution and visualization:w

    { src = "https://github.com/avante-corp/avante.nvim",                         version = vim.version.range("0.*") }, -- Avante: AI-powered code generation and assistance
})
