{ pkgs, ... }: {
  home.packages = with pkgs; [
    # vale
    # vscode-extensions.vadimcn.vscode-lldb.adapter # Currently broken on the mac
    alejandra # Alejandra nix formatting
    black # python formatter
    code-lldb
    coursier
    dprint
    efm-langserver # EFM language server
    graphviz # rustacean graph crate functionality
    hadolint
    html-tidy # html/xml formatter
    jdt-language-server # java language server
    lua-language-server # Lua language server
    lua5_1
    luarocks
    markdownlint-cli2
    nil # nix language server
    nixfmt-classic
    nodePackages.vscode-langservers-extracted
    pyright # Pyright language server
    topiary
    tree-sitter
    typescript-language-server
    vscode-extensions.vscjava.vscode-java-test
    yaml-language-server # YAML language server
    yq
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
        # Build failure 2024-03-17
        # plotly # for image rendering
        # plotly broken 2025-06-23
        # pnglatex # for image rendering
        cairosvg # for image rendering
        jupyter-client
        nbformat
        pynvim
        pyperclip
      ];
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
