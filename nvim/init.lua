require("opts")
require("lsp")

vim.cmd.colorscheme(vim.g.theme_name)
require("nu_runner")

function _G.copy_path()
    vim.fn.setreg('+', vim.fn.expand('%:p'))
end
