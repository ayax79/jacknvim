vim.api.nvim_create_user_command('Nu', function(opts)
        local cmd = opts.args
        local table_mode = opts.fargs[1]

        -- Check if first argument looks like a table mode option
        if table_mode and table_mode:match('^table_mode=') then
            -- Extract the table mode value
            local mode_value = table_mode:match('^table_mode=(.+)$')
            -- Remove the table-mode argument from the command
            cmd = table.concat(vim.list_slice(opts.fargs, 2), ' ')
            -- Prepend the env config setting
            cmd = '\\$env.config.table.mode = \\"' .. mode_value .. '\\"; ' .. cmd
        end

        local output = vim.fn.system('nu -c "' .. cmd .. '"')
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({ { 'Nushell error: ' .. output } }, true, { err = true })
        else
            print(output)
        end
    end,
    {
        nargs = '+',
        desc =
        'Run a Nushell command and print the output. Use table_mode=<mode> to set table display mode.'
    }
)
