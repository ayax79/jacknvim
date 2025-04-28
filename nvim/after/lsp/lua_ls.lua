return {
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace",
            },
            workspace = {
                -- ke the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
}
