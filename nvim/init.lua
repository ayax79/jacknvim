require("opts")

-- This wraps the calls to lazy so that the lsp
-- settings that need to applied before and after plugins
-- are loaded happens correctly
require("lsp").initialize(function()
    require("config.lazy")
end)

-- vim.cmd.colorscheme(vim.g.theme_name)
vim.cmd.colorscheme("kanagawa-dragon")

-- key mappings including which key
require("keys")
