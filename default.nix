{pkgs, ...}: let
  treesitterWithGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.comment
    p.css
    p.dockerfile
    p.fish
    p.gitattributes
    p.gitignore
    p.go
    p.gomod
    p.gosum
    p.gowork
    p.hcl
    p.java
    p.javascript
    p.jq
    p.json5
    p.json
    p.lua
    p.make
    p.markdown
    p.nix
    p.nu
    p.python
    p.rust
    p.toml
    p.typescript
    p.vue
    p.yaml
  ]);
in {
  home.packages = with pkgs; [
    hadolint
    dprint
    yq
    tree-sitter
    nil # nix language server
    jdt-language-server # java language server
    nodePackages.vscode-langservers-extracted
    yaml-language-server # YAML language server
    efm-langserver # EFM language server
    terraform-lsp # terrform language server
    pyright # Pyright language server
    alejandra # Alejandra nix formatting
    # Lua language server
    lua-language-server
    vscode-extensions.vscjava.vscode-java-test
    # Currently broken on the mac
    # vscode-extensions.vadimcn.vscode-lldb.adapter
    coursier
    black # python formatter
    code-lldb
    luarocks
    lua5_1
    html-tidy # html/xml formatter
    typescript-language-server
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    coc.enable = false;
    vimAlias = true;
    # extraConfig = ":luafile ~/.config/nvim/init.lua";
    plugins = [
      treesitterWithGrammars
      pkgs.vimPlugins.nvim-lsp-ts-utils
    ];
  };

  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };
}
