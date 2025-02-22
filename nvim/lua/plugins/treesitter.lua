return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
        ensure_installed = { "nu", "lua", "rust", "toml", "markdown", "markdown_inline", "regex", "go" },
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "markdown" },
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
        },
    },
    -- config = function(_, opts)
    --     local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    --     parser_config.nu = {
    --         install_info = {
    --             url = "~/nikedev/nushell/tree-sitter-nu",            -- local path or git repo
    --             files = { "src/parser.c", "src/scanner.c" },     -- note that some parsers also require src/scanner.c or src/scanner.cc
    --             branch = "main",                                 -- default branch in case of git repo if different from master
    --             generate_requires_npm = false,                   -- if stand-alone parser without npm dependencies
    --             requires_generate_from_grammar = false,          -- if folder contains pre-generated src/parser.c
    --         },
    --         filetype = "nu",                                     -- if filetype does not match the parser name
    --     }
    --     require("nvim-treesitter.configs").setup(opts)
    -- end,
    dependencies = { 'nushell/tree-sitter-nu' },
}
