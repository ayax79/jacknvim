-- Supported themes
-- nord, noridc, onenord
vim.g.theme_name = "nord"

require("opts")

-- This step will load constants, functions etc
-- that should be loaded before lazy
local lsp = require("lsp")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- the lazy package manager initialization and plugins are here
local plugins = require("plugins")
local lazy_opts = {
    install = {
        colorscheme = { vim.g.theme_name },
    },
}
require("lazy").setup(plugins, lazy_opts)

-- lsp configuration post lazy setup (lspconfig requriement)
lsp.setup()

-- key mappings including which key
require("keys")
