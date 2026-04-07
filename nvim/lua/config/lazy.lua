-- DEPRECATED: lazy.nvim bootstrap replaced by config/pack.lua
-- This file previously bootstrapped folke/lazy.nvim. The config now uses
-- Neovim's pack feature (pack/vendor/start) and a loader at lua/config/pack.lua.
--
-- Kept as a small compatibility shim to avoid errors from any lingering
-- require('config.lazy') calls.

-- Provide a minimal shim for require('lazy') so code that calls
-- require('lazy').setup(...) won't error. It does nothing.
package.loaded['lazy'] = nil
package.preload['lazy'] = function()
    return {
        setup = function(_) end,
    }
end
