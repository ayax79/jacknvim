return {
    root_markers = { "flake.nix", "default.nix", "shell.nix" },
    settings = {
        ['nil'] = {
            autoArchive = true,
            formatting = {
                command = { "nixfmt" },
            }
        },
    },
}
