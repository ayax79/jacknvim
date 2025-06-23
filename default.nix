{ pkgs, ... }: {
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
    nixfmt-classic
    topiary
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    coc.enable = false;
    vimAlias = true;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = [ pkgs.imagemagick ];
    extraPython3Packages = ps:
      with ps; [
        # ... other python packages
        pynvim
        jupyter-client
        cairosvg # for image rendering
        # Build failure 2024-03-17
        # pnglatex # for image rendering
        # plotly broken 2025-06-23
        # plotly # for image rendering
        pyperclip
        nbformat
      ];
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
