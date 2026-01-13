vim.api.nvim_create_user_command('Nu', function(opts)
    local cmd = opts.args
    local output = vim.fn.system('nu -c "' .. cmd .. '"')
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({ { 'Nushell error: ' .. output } }, true, { err = true })
    else
        print(output)
    end
end, { nargs = '+', desc = 'Run a Nushell command and print the output' })
