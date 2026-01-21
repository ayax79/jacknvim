return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treesitter** module to be loaded in time.
        -- Luckily, the only things that those plugins need are the custom queries, which we make available
        -- during startup.
        require("lazy.core.loader").add_to_rtp(plugin)
        -- require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },
    keys = {
        { "<c-space>", desc = "Increment Selection" },
        { "<bs>",      desc = "Decrement Selection", mode = "x" },
    },
    opts = {
        ensure_installed = {
            "comment",
            "css",
            "go",
            "gomod",
            "gosum",
            "gotmpl",
            "gowork",
            "html",
            "json",
            "lua",
            "markdown_inline",
            "markdown",
            "nix",
            "norg",
            "nu",
            "regex",
            "rust",
            "scss",
            "sql",
            "svelte",
            "toml",
            "tsx",
            "typst",
            "vue",

        },
        sync_install = false,
        auto_install = true,
        ignore_install = false,
        highlight = {
            enable = true,
            -- additional_vim_regex_highlighting = { "markdown" },
            additional_vim_regex_highlighting = false,
        },
        ident = { enable = true },
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
        textobjects = {
            move = {
                enable = true,
                goto_next_start = { ["]m"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
                goto_next_end = { ["]M"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
                goto_previous_start = { ["[m"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
                goto_previous_end = { ["[M"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
            },
            keymaps = {
                -- Nushell only
                ["aP"] = "@pipeline.outer",
                ["iP"] = "@pipeline.inner",

                -- supported in other languages as well
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["aC"] = "@conditional.outer",
                ["iC"] = "@conditional.inner",
                ["iS"] = "@statement.inner",
                ["aS"] = "@statement.outer",
            }
        },
    },
    config = function(_, opts)
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.nu = {
            install_info = {
                url = vim.fn.expand("$HOME/nikedev/nushell/tree-sitter-nu"),    -- local path or git repo
                files = { "src/parser.c", "src/scanner.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
                branch = "main",                             -- default branch in case of git repo if different from master
                generate_requires_npm = false,               -- if stand-alone parser without npm dependencies
                requires_generate_from_grammar = false,      -- if folder contains pre-generated src/parser.c
            },
            filetype = "nu",                                 -- if filetype does not match the parser name
        }
        require("nvim-treesitter.configs").setup(opts)
    end,
    -- dependencies = { 'nushell/tree-sitter-nu' },
}
