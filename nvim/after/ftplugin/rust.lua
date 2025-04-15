local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
    "n",
    "<leader>la",
    function()
        vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
        -- or vim.lsp.buf.codeAction() if you don't want grouping.
    end,
    { silent = true, buffer = bufnr }
)
vim.keymap.set(
    "n",
    "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
    function()
        vim.cmd.RustLsp({ 'hover', 'actions' })
    end,
    { silent = true, buffer = bufnr }
)
-- Runnables

vim.keymap.set("n", "<Leader>lr", function() vim.cmd.RustLsp { 'runnables' } end,
    { desc = "Runnables" })
vim.keymap.set("n", "<Leader>lR", function() vim.cmd.RustLsp { 'runnables', 'last' } end,
    { desc = "Run Last" })

vim.keymap.set("n", "<Leader>ldr", function() vim.cmd.RustLsp { 'debuggables' } end,
    { desc = "Debuggables" })
vim.keymap.set("n", "<Leader>ldR", function() vim.cmd.RustLsp { 'debuggables', 'last' } end,
    { desc = "Debug Last" })

vim.keymap.set("n", "<Leader>ltr", function() vim.cmd.RustLsp { 'testables' } end,
    { desc = "Testables" })
vim.keymap.set("n", "<Leader>ltR", function() vim.cmd.RustLsp { 'testables', 'last' } end,
    { desc = "Test Last" })
