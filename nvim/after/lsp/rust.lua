return {
    settings = {
        ['rust-analyzer'] = {
            diagnostics = { disabled = { "inactive-code" } },
            files = {
                excludeDirs = {
                    ".dart_tool",
                    ".flatpak-builder",
                    ".git",
                    ".gitlab",
                    ".gitlab-ci",
                    ".gradle",
                    ".idea",
                    ".next",
                    ".project",
                    ".scannerwork",
                    ".settings",
                    ".venv",
                    "_build",
                    "archetype-resources",
                    "bin",
                    "hooks",
                    "node_modules",
                    "po",
                    "screenshots",
                    "target"
                }
            }
        },
    }
}
