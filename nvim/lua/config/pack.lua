-- Minimal pack-based plugin loader using runtimepath's pack feature
-- This file replaces config.lazy and expects plugins to be installed under
-- pack/vendor/start in either XDG_DATA_HOME or the config directory.

local uv = vim.loop or vim.uv

local function ensure_runtime_dirs()
    local data_dir = vim.fn.stdpath('data')
    local pack_dirs = {
        data_dir .. '/site/pack/vendor/start',
        data_dir .. '/site/pack/vendor/opt',
        vim.fn.stdpath('config') .. '/pack/vendor/start',
        vim.fn.stdpath('config') .. '/pack/vendor/opt',
    }

    local function mkdirp(p)
        if not uv.fs_stat(p) then
            uv.fs_mkdir(p, 448) -- 0700
        end
    end

    for _, p in ipairs(pack_dirs) do
        -- ensure parent dirs exist for data-side paths only
        local parent = p:match('^(.*)/pack')
        if parent and not uv.fs_stat(parent) then
            mkdirp(parent)
        end
        if not uv.fs_stat(p) then
            -- best-effort, ignore errors
            pcall(uv.fs_mkdir, p, 448)
        end
    end
end

ensure_runtime_dirs()

-- Add start plugins from both data and config pack dirs to runtimepath
local function add_start_plugins()
    local dirs = {
        vim.fn.stdpath('data') .. '/site/pack/vendor/start',
        vim.fn.stdpath('config') .. '/pack/vendor/start',
    }

    for _, start in ipairs(dirs) do
        local ok, iter = pcall(vim.fs.dir, start)
        if not ok or not iter then goto continue end
        for name in iter do
            local p = start .. '/' .. name
            if vim.fn.isdirectory(p) == 1 then
                vim.opt.rtp:append(p)
            end
        end
        ::continue::
    end
end

add_start_plugins()

-- Loader for plugin specification files under lua/plugins/*.lua
-- Each file in lua/plugins currently returns a lazy.nvim-style spec table.
-- We keep that shape but, when a plugin is present in pack start, we call
-- its setup/config/init as appropriate.
local function load_plugin_specs()
    local cfg_dir = vim.fn.stdpath('config')
    local files = vim.fn.globpath(cfg_dir .. '/lua/plugins', '*.lua', false, true)
    if not files or #files == 0 then return end

    for _, f in ipairs(files) do
        local mod = f:match(cfg_dir .. '/lua/(.*)%.lua$')
        if not mod then goto continue end
        mod = mod:gsub('/', '.')
        local ok, spec = pcall(require, mod)
        if not ok or type(spec) ~= 'table' then goto continue end

        -- Optional init function (run regardless)
        if type(spec.init) == 'function' then
            pcall(spec.init)
        end

        -- Determine repo/name for installation checks
        local repo = spec[1]
        local name
        if type(repo) == 'string' then
            name = repo:match('/([^/]+)$')
        end

        local installed = false
        if name then
            local starts = {
                vim.fn.stdpath('data') .. '/site/pack/vendor/start/',
                vim.fn.stdpath('config') .. '/pack/vendor/start/',
            }
            for _, base in ipairs(starts) do
                if vim.fn.isdirectory(base .. name) == 1 then
                    installed = true
                    break
                end
            end
        end

        if not installed then
            -- plugin not present in pack start; skip runtime setup
            goto continue
        end

        -- If spec.config is provided prefer running it (it usually calls .setup)
        if type(spec.config) == 'function' then
            pcall(spec.config)
        elseif type(spec.opts) == 'table' and type(repo) == 'string' then
            -- Try to require the plugin module and call setup(opts)
            -- Derive a module name from the repo name (best-effort).
            local plugmod = name or repo
            plugmod = plugmod:gsub('%.nvim$', ''):gsub('%.vim$', '')
            plugmod = plugmod:gsub('%-', '_')
            local ok2, plug = pcall(require, plugmod)
            if ok2 and type(plug.setup) == 'function' then
                pcall(plug.setup, spec.opts)
            end
        end

        -- Keys: translate lazy.nvim style key tables into vim.keymap.set
        if type(spec.keys) == 'table' then
            for _, k in ipairs(spec.keys) do
                if type(k) == 'table' then
                    local lhs = k[1]
                    local rhs = k[2]
                    local desc = k.desc
                    local mode = k.mode or 'n'
                    local map_opts = {}
                    if k.nowait then map_opts.nowait = true end
                    if desc then map_opts.desc = desc end
                    if type(mode) == 'table' then
                        for _, m in ipairs(mode) do
                            pcall(vim.keymap.set, m, lhs, rhs, map_opts)
                        end
                    else
                        pcall(vim.keymap.set, mode, lhs, rhs, map_opts)
                    end
                end
            end
        end

        ::continue::
    end
end

-- Run the loader
load_plugin_specs()

-- Emit the legacy `User VeryLazy` autocommand so plugins that set up
-- autocommands on that event (from lazy.nvim-style specs) still get their
-- callbacks invoked. This approximates lazy.nvim's scheduling of VeryLazy.
pcall(vim.api.nvim_exec, 'doautocmd User VeryLazy', false)

-- Provide a minimal compatibility shim for 'require("lazy")' calls if any remain.
package.loaded['lazy'] = nil
package.preload['lazy'] = function()
    return {
        setup = function() end,
    }
end
