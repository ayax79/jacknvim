return {
    "benlubas/molten-nvim",
    enabled = false,
    --version = "^1.9.2",     -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    keys = {
        {
            "<leader>ji",
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
        { "<leader>jc", ":MoltenReevaluateCell<CR>",        desc = "re-evaluate cell" },
        { "<leader>jd", ":MoltenDelete<CR>",                desc = "molten delete cell" },
        { "<leader>jh", ":MoltenHideOutput<CR>",            desc = "hide output" },
        { "<leader>jl", ":MoltenEvaluateLine<CR>",          desc = "evaluate line" },
        { "<leader>jo", ":MoltenEvaluateOperator<CR>",      desc = "run operator selection" },
        { "<leader>js", ":noautocmd MoltenEnterOutput<CR>", desc = "show/enter output" },
        { "<leader>jv", ":<C-u>MoltenEvaluateVisual<CR>gv", desc = "evaluate visual selection", mode = "v" },
    },
    init = function()
        -- I find auto open annoying, keep in mind setting this option will require setting
        -- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
        vim.g.molten_auto_open_output = false

        -- this guide will be using image.nvim
        -- Don't forget to setup and install the plugin if you want to view image outputs
        vim.g.molten_image_provider = "image.nvim"

        -- optional, I like wrapping. works for virt text and the output window
        vim.g.molten_wrap_output = true

        -- Output as virtual text. Allows outputs to always be shown, works with images, but can
        -- be buggy with longer images
        vim.g.molten_virt_text_output = true

        -- this will make it so the output shows up below the \`\`\` cell delimiter
        vim.g.molten_virt_lines_off_by_1 = true

        vim.g.molten_output_win_max_height = 20
    end,
}
