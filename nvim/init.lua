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

vim.api.nvim_create_user_command('Grip', function(opts)
    vim.cmd(string.format("!pueue add --label grip 'go-grip %s' ", opts.args ~= "" and opts.args or vim.fn.expand('%:p')))
end, { range = true, nargs = '?' })
