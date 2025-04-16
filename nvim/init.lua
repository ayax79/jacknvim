require("opts")

-- This step will load constants, functions etc
-- that should be loaded before lazy
local lsp = require("lsp")

require("config.lazy")
vim.cmd.colorscheme(vim.g.theme_name)

-- lsp configuration post lazy setup (lspconfig requriement)
lsp.setup()

-- key mappings including which key
require("keys")
