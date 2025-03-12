vim.keymap.set(
    "n",
    "<C-space>",
    function() vim.cmd.RustLsp { 'hover', 'actions' } end,
    { desc = "Show hover actions" }
)
-- Code action groups
vim.keymap.set(
    "n",
    "<Leader>la",
    function() vim.cmd.RustLsp('codeAction') end,
    { desc = "Code Action Group" }
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
