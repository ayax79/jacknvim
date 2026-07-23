require("opts")
require("lsp")

require("nu_runner")

function _G.copy_path()
    vim.fn.setreg('+', vim.fn.expand('%:p'))
end

vim.api.nvim_create_user_command('CopyPath', function()
    _G.copy_path()
end, {})

vim.api.nvim_create_user_command('Say', function(opts)
    vim.cmd(string.format("'<,'>w !say -r %d &", opts.args ~= "" and tonumber(opts.args) or 300))
end, { range = true, nargs = '?' })
