require("opts")
require("lsp")
require("config.lazy")
vim.cmd.colorscheme(vim.g.theme_name)
require("keys")
require("nu_runner")


-- local util = require('lspconfig.util')
--
-- local function root_requires_all(markers)
--   return function(fname)
--     local root = util.root_pattern(markers[1])(fname)
--     if not root then return nil end
--
--     -- Check that all other markers exist in this root
--     for i = 2, #markers do
--       local marker_path = util.path.join(root, markers[i])
--       if not (util.path.is_file(marker_path) or util.path.is_dir(marker_path)) then
--         return nil
--       end
--     end
--
--     return root
--   end
-- end
--
-- local lspconfig = require('lspconfig')

-- local nix_markers = {'.git', 'flake.nix'}
-- lspconfig.nixd.setup({
--   root_dir = root_requires_all(nix_markers),
-- })
--
-- lspconfig.nixd.setup({
--   root_dir = root_requires_all(nix_markers),
-- })


vim.lsp.enable({
    -- "terraformls",
    "nixd",
    "nil_ls",
    "lua_ls",
    "nushell",
    "yamlls",
    "pyright",
    "ruff",
    "marksman",
    "ts_ls",
})
