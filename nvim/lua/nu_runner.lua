local function build_nu_cmd(args, fargs)
    local cmd = args
    local table_mode = fargs[1]
    if table_mode and table_mode:match('^table_mode=') then
        local mode_value = table_mode:match('^table_mode=(.+)$')
        cmd = '$env.config.table.mode = "' .. mode_value .. '"; ' .. cmd
    end
    return vim.fn.shellescape(cmd)
end

local function nu_eval(args, fargs)
    local nu_cmd = build_nu_cmd(args, fargs)
    local full = 'nu -l -c ' .. nu_cmd
    return vim.fn.system(full)
end

-- Return a string (no side effects), suitable for expression register
-- Markdowwn format will be be used by default unless overridden as it pasts in documents nicely
-- Example:  "= v.lua.nu('ls')
function _G.nu(args, fargs)
    local output = nu_eval(args, fargs or { "table_mode=markdown" })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({ { 'Nushell error: ' .. output } }, true, { err = true })
    end
    return output
end

vim.api.nvim_create_user_command('Nu', function(opts)
    local output = nu_eval(opts.args, opts.fargs)
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({ { 'Nushell error: ' .. output } }, true, { err = true })
    else
        print(output)
    end
end, {
    nargs = '+',
    desc = 'Run a Nushell command and insert its output. Use table_mode=<mode> to set table display mode.',
})
