{pkgs, ...}: {
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
    terraform-ls # terrform language server
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
    # rustacean graph crate functionality
    graphviz
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    coc.enable = false;
    vimAlias = true;
  };

  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };
}
