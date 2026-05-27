require("opts")
require("lsp")

require("nu_runner")

function _G.copy_path()
    vim.fn.setreg('+', vim.fn.expand('%:p'))
end
