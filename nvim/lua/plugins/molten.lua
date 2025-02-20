return {
    "benlubas/molten-nvim",
    --version = "^1.9.2",     -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    keys = {
        {
            "<leader>Mi",
            function()
                local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
                if venv ~= nil then
                    -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
                    venv = string.match(venv, "/.+/(.+)")
                    vim.cmd(("MoltenInit %s"):format(venv))
                else
                    vim.cmd("MoltenInit python3")
                end
            end,
            desc = "Initialize Molten for python3",
        },
        -- { "<leader>mi", ":MoltenInit<CR>",                  silent = true, desc = "Initialize the plugin" },
        { "<leader>Mo", ":MoltenEvaluateOperator<CR>",      desc = "run operator selection" },
        { "<leader>Ml", ":MoltenEvaluateLine<CR>",          desc = "evaluate line" },
        { "<leader>Mc", ":MoltenReevaluateCell<CR>",        desc = "re-evaluate cell" },
        { "<leader>Mv", ":<C-u>MoltenEvaluateVisual<CR>gv", desc = "evaluate visual selection", mode = "v" },
        { "<leader>Md", ":MoltenDelete<CR>",                desc = "molten delete cell" },
        { "<leader>Mh", ":MoltenHideOutput<CR>",            desc = "hide output" },
        { "<leader>Ms", ":noautocmd MoltenEnterOutput<CR>", desc = "show/enter output" },
    },
    init = function()
        -- these are examples, not defaults. Please see the readme
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_win_max_height = 20
    end,
}
