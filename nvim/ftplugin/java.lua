--
-- See `:help vim.lsp.start` for an overview of the supported `config` options.

local cmd = { "jdtls" }
if os.getenv("JDTLS_JAVA") then
    vim.list_extend(cmd, { "--java-executable", os.getenv("JDTLS_JAVA") })
end
vim.notify("jdtls command: " .. vim.inspect(cmd), vim.log.levels.INFO)
local config = {
    -- capabilities = capabilities,
    name = "jdtls",


    -- `cmd` defines the executable to launch eclipse.jdt.ls.
    -- `jdtls` must be available in $PATH and you must have Python3.9 for this to work.
    --
    -- As alternative you could also avoid the `jdtls` wrapper and launch
    -- eclipse.jdt.ls via the `java` executable
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    -- cmd = { "jdtls", "--data", workspace_dir },
    cmd = cmd,

    -- `root_dir` must point to the root of your project.
    -- See `:help vim.fs.root`
    -- root_dir = root_dir,


    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    -- settings = {
    --     java = {
    --     }
    -- },


    -- This sets the `initializationOptions` sent to the language server
    -- If you plan on using additional eclipse.jdt.ls plugins like java-debug
    -- you'll need to set the `bundles`
    --
    -- See https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on any eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {}
    },
}
-- Add spring-boot jdtls extension jars
-- vim.list_extend(config.init_options.bundles, require("spring_boot").java_extensions())
require('jdtls').start_or_attach(config)

vim.keymap.set('n', '<A-o>', function()
    require('jdtls').organize_imports()
end, { desc = 'JDTLS: Organize imports' })

vim.keymap.set('n', 'crv', function()
    require('jdtls').extract_variable()
end, { desc = 'JDTLS: Extract variable' })

vim.keymap.set('v', 'crv', function()
    require('jdtls').extract_variable()
end, { desc = 'JDTLS: Extract variable (visual)' })

vim.keymap.set('n', 'crc', function()
    require('jdtls').extract_constant()
end, { desc = 'JDTLS: Extract constant' })

vim.keymap.set('v', 'crc', function()
    require('jdtls').extract_constant()
end, { desc = 'JDTLS: Extract constant (visual)' })

vim.keymap.set('v', 'crm', function()
    require('jdtls').extract_method()
end, { desc = 'JDTLS: Extract method (visual)' })

-- If using nvim-dap / java test bundles
vim.keymap.set('n', '<leader>df', function()
    require('jdtls').test_class()
end, { desc = 'JDTLS: Test class' })

vim.keymap.set('n', '<leader>dn', function()
    require('jdtls').test_nearest_method()
end, { desc = 'JDTLS: Test nearest method' })
