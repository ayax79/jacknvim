# Neovim Configuration

<!-- markdownlint-disable line-length -->

A modern Neovim configuration built on **Neovim 0.12+** features—specifically
the built-in `vim.pack` package manager, native LSP via `vim.lsp.enable()`, and
treesitter-based folding. No external plugin manager (no lazy.nvim, no
packer)—just the built-in `vim.pack` that ships with Neovim 0.12.

## Architecture

```
nvim/
├── init.lua              # Entry point: loads opts, lsp, nu_runner
├── lua/
│   ├── opts.lua          # Global options (leader, tabs, folds, UI)
│   ├── lsp.lua           # LSP/DAP adapter paths, diagnostics config
│   ├── keys.lua          # which-key groups and LSP-attach keymaps
│   ├── lazyload.lua      # Deferred execution helpers (on_vim_enter)
│   ├── nu_runner.lua     # Nushell integration (:Nu command, expression register)
│   └── util.lua          # Small helpers (copy_table, with_description)
├── plugin/               # Sourced automatically by Neovim in order
│   ├── 00_packages.lua   # All plugin declarations (vim.pack.add)
│   ├── 01_colorschemes.lua  # Theme detection and colorscheme setup
│   ├── 02_snacks.lua     # Snacks.nvim config + picker/explorer keymaps
│   └── 03_setup.lua      # Deferred plugin setups (treesitter, completion, etc.)
├── after/
│   ├── lsp/              # Per-server LSP configurations
│   └── ftplugin/         # Per-filetype settings (rust keymaps, etc.)
├── ftplugin/             # Filetype plugins (java, python, scala, etc.)
└── rule/                 # External config (eclipse java style, etc.)
```

### Loading Strategy

1. **`init.lua`** — Loads global options and LSP diagnostics config immediately.
2. **`plugin/00_packages.lua`** — Declares all packages via the built-in
   `vim.pack.add()` (Neovim 0.12's native package manager—no lazy.nvim or packer
   needed).
3. **`plugin/01_colorschemes.lua`** — Sets up and applies the colorscheme
   (driven by `$THEME` env var).
4. **`plugin/02_snacks.lua`** — Configures Snacks.nvim (picker, explorer,
   notifications, etc.) and its keymaps.
5. **`plugin/03_setup.lua`** — Deferred setup for all other plugins using
   `lazyload.on_vim_enter()` to avoid blocking startup.
6. **`after/lsp/`** — Native Neovim LSP configs (new `vim.lsp.enable()` style).
7. **`after/ftplugin/`** — Filetype-specific keymaps (e.g., Rust-specific code
   actions).

## Plugin Categories

### Core / UI

| Plugin                                                       | Purpose                                                                      |
| ------------------------------------------------------------ | ---------------------------------------------------------------------------- |
| [snacks.nvim](https://github.com/folke/snacks.nvim)          | Swiss-army knife: picker, explorer, notifications, zen, terminal, git browse |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline                                                                   |
| [tabby.nvim](https://github.com/nanozuki/tabby.nvim)         | Tab bar                                                                      |
| [which-key.nvim](https://github.com/folke/which-key.nvim)    | Keymap hints (helix preset)                                                  |
| [trouble.nvim](https://github.com/folke/trouble.nvim)        | Diagnostics / quickfix panel                                                 |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim)          | LSP progress indicator                                                       |

### Navigation / File Management

| Plugin                                                                  | Purpose                                 |
| ----------------------------------------------------------------------- | --------------------------------------- |
| [oil.nvim](https://github.com/stevearc/oil.nvim)                        | File explorer as a buffer (`-` to open) |
| [yazi.nvim](https://github.com/mikavilpas/yazi.nvim)                    | Yazi file manager integration           |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless tmux/nvim pane navigation      |

### Completion / Snippets

| Plugin                                                               | Purpose                                   |
| -------------------------------------------------------------------- | ----------------------------------------- |
| [blink.cmp](https://github.com/saghen/blink.cmp)                     | Fast completion engine (Rust-based fuzzy) |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippet collection                        |

### LSP / Formatting / Linting

| Plugin                                                      | Purpose                                                       |
| ----------------------------------------------------------- | ------------------------------------------------------------- |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)  | LSP configuration                                             |
| [mason.nvim](https://github.com/mason-org/mason.nvim)       | LSP/DAP/linter installer                                      |
| [conform.nvim](https://github.com/stevearc/conform.nvim)    | Formatting (topiary for nu, dprint for md/toml, LSP fallback) |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint)      | Async linting (fish, markdownlint)                            |
| [SchemaStore.nvim](https://github.com/b0o/SchemaStore.nvim) | JSON/YAML schema catalog                                      |

### Treesitter

| Plugin                                                                                                | Purpose                            |
| ----------------------------------------------------------------------------------------------------- | ---------------------------------- |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)                                 | Parser management and auto-install |
| [ts-comments.nvim](https://github.com/folke/ts-comments.nvim)                                         | Treesitter-aware commenting        |
| [tree-sitter-language-injection](https://github.com/dariuscorvus/tree-sitter-language-injection.nvim) | Language injection support         |

### Git

| Plugin                                                            | Purpose                            |
| ----------------------------------------------------------------- | ---------------------------------- |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)       | Git hunk signs, stage/reset, blame |
| [vim-fugitive](https://github.com/tpope/vim-fugitive)             | Git commands                       |
| [git-conflict.nvim](https://github.com/akinsho/git-conflict.nvim) | Merge conflict resolution          |
| Snacks lazygit                                                    | Lazygit integration (`<leader>gg`) |

### Debugging / Testing

| Plugin                                                 | Purpose                |
| ------------------------------------------------------ | ---------------------- |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap)   | Debug Adapter Protocol |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | DAP UI                 |
| [neotest](https://github.com/nvim-neotest/neotest)     | Test runner framework  |

### Language-Specific

| Plugin                                                        | Purpose                        |
| ------------------------------------------------------------- | ------------------------------ |
| [rustaceanvim](https://github.com/mrcjkb/rustaceanvim)        | Rust (rust-analyzer, codelldb) |
| [crates.nvim](https://github.com/saecki/crates.nvim)          | Cargo.toml crate management    |
| [nvim-metals](https://github.com/scalameta/nvim-metals)       | Scala (Metals LSP)             |
| [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)      | Java (Eclipse JDT.LS)          |
| [nvim-coverage](https://github.com/andythigpen/nvim-coverage) | Code coverage display          |

### AI

| Plugin                                                   | Purpose                            |
| -------------------------------------------------------- | ---------------------------------- |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | GitHub Copilot (claude-sonnet-4.5) |
| [avante.nvim](https://github.com/yetone/avante.nvim)     | AI chat/edit (goose provider)      |

### Editing

| Plugin                                                               | Purpose                                                         |
| -------------------------------------------------------------------- | --------------------------------------------------------------- |
| [mini.nvim](https://github.com/nvim-mini/mini.nvim)                  | align, ai textobjects, icons, move, jump2d, splitjoin, surround |
| [multicursor.nvim](https://github.com/jake-stewart/multicursor.nvim) | Multiple cursors                                                |
| [vim-abolish](https://github.com/tpope/vim-abolish)                  | Case-preserving substitution                                    |
| [vim-camelsnek](https://github.com/nicwest/vim-camelsnek)            | Case conversion                                                 |

## Keybindings

**Leader key: `<Space>`**

### General

| Key          | Mode | Description                 |
| ------------ | ---- | --------------------------- |
| `-`          | n    | Open parent directory (Oil) |
| `<leader>e`  | n    | File Explorer (Snacks)      |
| `<leader>-`  | n    | Open Yazi at current file   |
| `<leader>cw` | n    | Open Yazi at cwd            |
| `<leader>z`  | n    | Toggle Zen Mode             |
| `<leader>Z`  | n    | Toggle Zoom                 |
| `<leader>.`  | n    | Toggle Scratch Buffer       |
| `<leader>N`  | n    | Neovim News                 |
| `<c-/>`      | n    | Toggle Terminal             |

### Find / Picker (`<leader>f` / `<leader>s`)

| Key               | Mode | Description           |
| ----------------- | ---- | --------------------- |
| `<leader><space>` | n    | Smart Find Files      |
| `<leader>,`       | n    | Buffers               |
| `<leader>//`      | n    | Grep                  |
| `<leader>:`       | n    | Command History       |
| `<leader>ff`      | n    | Find Files            |
| `<leader>fg`      | n    | Find Git Files        |
| `<leader>fr`      | n    | Recent Files          |
| `<leader>fp`      | n    | Projects              |
| `<leader>fc`      | n    | Find Config File      |
| `<leader>sg`      | n    | Grep                  |
| `<leader>sw`      | n, x | Grep word/selection   |
| `<leader>sb`      | n    | Buffer Lines          |
| `<leader>sB`      | n    | Grep Open Buffers     |
| `<leader>sd`      | n    | Diagnostics           |
| `<leader>ss`      | n    | LSP Symbols           |
| `<leader>sS`      | n    | LSP Workspace Symbols |
| `<leader>sk`      | n    | Keymaps               |
| `<leader>sh`      | n    | Help Pages            |
| `<leader>st`      | n    | AST Grep              |
| `<leader>sT`      | n    | Tab Pages             |
| `<leader>su`      | n    | Undo History          |
| `<leader>sR`      | n    | Resume last picker    |

### Git (`<leader>g`)

| Key          | Mode | Description                  |
| ------------ | ---- | ---------------------------- |
| `<leader>gg` | n    | Lazygit                      |
| `<leader>gb` | n    | Git Branches                 |
| `<leader>gl` | n    | Git Log                      |
| `<leader>gs` | n    | Git Status                   |
| `<leader>gd` | n    | Git Diff (Hunks)             |
| `<leader>gf` | n    | Git Log File                 |
| `<leader>gB` | n, v | Git Browse (open in browser) |
| `<leader>gi` | n    | GitHub Issues (open)         |
| `<leader>gp` | n    | GitHub Pull Requests (open)  |

### Git Hunks (`<leader>h` — buffer-local via gitsigns)

| Key          | Mode | Description                      |
| ------------ | ---- | -------------------------------- |
| `]c` / `[c`  | n    | Next/Previous uncommitted change |
| `<leader>hs` | n, v | Stage Hunk                       |
| `<leader>hr` | n, v | Reset Hunk                       |
| `<leader>hS` | n    | Stage Buffer                     |
| `<leader>hR` | n    | Reset Buffer                     |
| `<leader>hp` | n    | Preview Hunk                     |
| `<leader>hb` | n    | Blame Line                       |
| `<leader>hd` | n    | Diff This                        |
| `<leader>tb` | n    | Toggle Current Line Blame        |
| `<leader>tw` | n    | Toggle Word Diff                 |

### LSP (`<leader>l`)

| Key          | Mode | Description                              |
| ------------ | ---- | ---------------------------------------- |
| `gd`         | n    | Go to Definition                         |
| `gD`         | n    | Go to Declaration                        |
| `grr`        | n    | References                               |
| `gri`        | n    | Go to Implementation                     |
| `gy`         | n    | Go to Type Definition                    |
| `gai`        | n    | Incoming Calls                           |
| `gao`        | n    | Outgoing Calls                           |
| `<M-k>`      | n    | Signature Help                           |
| `<leader>la` | n    | Code Action (Rust-specific in .rs files) |
| `<leader>ll` | n    | CodeLens Action                          |
| `<leader>lf` | n, v | Format (conform)                         |
| `<space>D`   | n    | Type Definition                          |

### Rust-Specific (`<leader>l` in .rs files)

| Key           | Mode | Description                  |
| ------------- | ---- | ---------------------------- |
| `K`           | n    | Hover Actions (rustaceanvim) |
| `<leader>la`  | n    | Rust Code Action             |
| `<leader>lr`  | n    | Runnables                    |
| `<leader>lR`  | n    | Run Last                     |
| `<leader>ldr` | n    | Debuggables                  |
| `<leader>ldR` | n    | Debug Last                   |
| `<leader>ltr` | n    | Testables                    |
| `<leader>ltR` | n    | Test Last                    |

### Crates (`<leader>c` — in Cargo.toml)

| Key          | Mode | Description         |
| ------------ | ---- | ------------------- |
| `<leader>ct` | n    | Toggle Crates       |
| `<leader>cv` | n    | Show Versions Popup |
| `<leader>cf` | n    | Show Features Popup |
| `<leader>cu` | n    | Update Crate        |
| `<leader>ca` | n    | Update All Crates   |
| `<leader>cU` | n    | Upgrade Crate       |
| `<leader>cA` | n    | Upgrade All Crates  |

### Debugger (`<leader>lD`)

| Key           | Mode | Description        |
| ------------- | ---- | ------------------ |
| `<leader>lDb` | n    | Toggle Breakpoint  |
| `<leader>lDu` | n    | Toggle Debugger UI |

### Trouble (`<leader>o`)

| Key          | Mode | Description                          |
| ------------ | ---- | ------------------------------------ |
| `<leader>ox` | n    | Diagnostics (Trouble)                |
| `<leader>oX` | n    | Buffer Diagnostics (Trouble)         |
| `<leader>os` | n    | Symbols (Trouble)                    |
| `<leader>ol` | n    | LSP Definitions/References (Trouble) |

### Tabs (`<leader>t`)

| Key          | Mode | Description      |
| ------------ | ---- | ---------------- |
| `<leader>ta` | n    | New Tab          |
| `<leader>tc` | n    | Close Tab        |
| `<leader>tn` | n    | Next Tab         |
| `<leader>tp` | n    | Previous Tab     |
| `<leader>to` | n    | Close Other Tabs |

### Multicursor

| Key               | Mode | Description                  |
| ----------------- | ---- | ---------------------------- |
| `<Up>` / `<Down>` | n, x | Add cursor above/below       |
| `<leader>n`       | n, x | Add cursor at next match     |
| `<leader>A`       | n, x | Add cursors at all matches   |
| `<leader>x`       | n, x | Delete cursor                |
| `<c-q>`           | n, x | Toggle cursor                |
| `<Esc>`           | n    | Clear cursors                |
| `S`               | x    | Split selection into cursors |

### Copilot (Insert Mode)

| Key     | Mode | Description         |
| ------- | ---- | ------------------- |
| `<C-J>` | i    | Accept suggestion   |
| `<C-K>` | i    | Dismiss suggestion  |
| `<C-H>` | i    | Previous suggestion |
| `<C-L>` | i    | Next suggestion     |

### Tmux Navigation

| Key     | Mode | Description               |
| ------- | ---- | ------------------------- |
| `<C-h>` | n    | Navigate left (tmux/nvim) |
| `<C-j>` | n    | Navigate down             |
| `<C-k>` | n    | Navigate up               |
| `<C-l>` | n    | Navigate right            |

### Toggle Options (`<leader>u`)

| Key          | Mode | Description                  |
| ------------ | ---- | ---------------------------- |
| `<leader>us` | n    | Toggle Spelling              |
| `<leader>uw` | n    | Toggle Wrap                  |
| `<leader>ul` | n    | Toggle Line Number           |
| `<leader>uL` | n    | Toggle Relative Number       |
| `<leader>ud` | n    | Toggle Diagnostics           |
| `<leader>uc` | n    | Toggle Conceal Level         |
| `<leader>uT` | n    | Toggle Treesitter            |
| `<leader>ub` | n    | Toggle Dark/Light Background |
| `<leader>uh` | n    | Toggle Inlay Hints           |
| `<leader>ug` | n    | Toggle Indent Guides         |
| `<leader>uC` | n    | Colorschemes picker          |

## LSP Servers

Configured and enabled via native `vim.lsp.enable()`:

| Server             | Language                |
| ------------------ | ----------------------- |
| `nixd` / `nil_ls`  | Nix                     |
| `lua_ls`           | Lua                     |
| `nushell`          | Nushell                 |
| `yamlls`           | YAML                    |
| `pyright` / `ruff` | Python                  |
| `marksman`         | Markdown                |
| `ts_ls`            | TypeScript              |
| `rust-analyzer`    | Rust (via rustaceanvim) |
| `metals`           | Scala (via nvim-metals) |
| `jdtls`            | Java (via nvim-jdtls)   |
| `helm_ls`          | Helm                    |
| `jsonls`           | JSON                    |

## Colorschemes

The active colorscheme is controlled by the `$THEME` environment variable (set
via Nix/home-manager). Supported themes:

- **catppuccin** (default) → `catppuccin-mocha`
- **gruvbox** → `gruvbox-material`
- **nord** → `onenord`
- **kanagawa** (wave/dragon/lotus)
- **everforest**
- **onedark**

## Nushell Integration

The `:Nu` command lets you run Nushell expressions directly in Neovim:

```vim
:Nu ls | where size > 1mb
:Nu sys host | get hostname
```

You can also use the expression register: `"=v:lua.nu('ls')` to insert Nushell
output.

## Notable Options

- **Leader**: `<Space>`
- **Relative line numbers**: enabled
- **Tab width**: 4 spaces
- **Whitespace**: visible (eol: `↴`, space: `⋅`)
- **Undo**: persistent across sessions
- **Folding**: treesitter-based expression folding
- **Format on demand**: `<leader>lf` (conform with LSP fallback)
- **Grep**: uses `rg --vimgrep`
