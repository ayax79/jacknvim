vim.g.theme_name = "everforest"

-- Disabling netrw because it is replaced by Oil
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.wo.relativenumber = true
vim.wo.number = true
-- vim.o.statuscolumn = "%s %l %=%{v:relnum?v:relnum:v:lnum} "
-- vim.wo.colorcolumn = "120"

-- maintain undo history between sessions
vim.cmd([[
set undofile
]])

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

-- default tab settings
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- white space settings
vim.opt.list = true
vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("space:⋅")

-- set termguicolors to enable highlight groups

-- git blame off by default
vim.g.gitblame_enabled = 0

vim.filetype.add({
    extension = {
        avsc = "json",
    },
    filename = {
        ["Jenkinsfile"] = "groovy",
        ["Jenkinsfile.rollback"] = "groovy",
        ["AutoJenkinsfile"] = "groovy",
    },
})

vim.o.cursorline = true

vim.o.conceallevel = 2

-- -- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- vim.o.shell = 'nu'
--
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 99

vim.opt.numberwidth = 3
vim.opt.signcolumn = "yes:1"
vim.opt.statuscolumn = "%l%s"
