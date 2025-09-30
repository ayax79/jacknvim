return {
    "yetone/avante.nvim",
    -- dir = vim.fn.expand("$HOME/nikedev/yetone/avante.nvim"),
    enabled = true,
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
        -- provider = "copilot",
        provider = "goose",
        --     vendors = {
        --         ollama = {
        --             __inherited_from = "openai",
        --             api_key_name = "",
        --             endpoint = "http://127.0.0.1:11434/v1",
        --             -- endpoint = "http://127.0.0.1:11434/api",
        --             model = "deepseek-coder",
        --         },
        --     },
        -- acp_providers = {
        --     ["goose"] = {
        --         command = vim.fn.expand("$HOME/.cargo/bin/goose"),
        --         args = { "acp" },
        --         env = {
        --             -- RUST_LOG = "agent_client_protocol=trace,mcp_client=debug,goose_cli=debug",
        --             RUST_LOG = "trace",
        --         },
        --     },
        -- },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua",      -- for providers='copilot'
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}
