{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # vale
    # vscode-extensions.vadimcn.vscode-lldb.adapter # Currently broken on the mac
    alejandra # Alejandra nix formatting
    # basedpyright
    vscode-extensions.vadimcn.vscode-lldb # codelldb DAP adapter
    coursier
    dprint
    # efm-langserver # EFM language server
    graphviz # rustacean graph crate functionality
    hadolint
    helm-ls
    html-tidy # html/xml formatter
    jdt-language-server # java language server
    lua-language-server # Lua language server
    lua5_1
    luarocks
    # marksman # Disabled: requires .NET which pulls in Swift on macOS ARM, causing slow GitHub CI builds
    markdownlint-cli2
    nil # nix language server
    nixd # nix language server
    nixfmt
    nix-tree # dependency tree for nix
    pyright # Pyright language server
    ruff # python formatter
    stylua
    topiary
    tombi
    tree-sitter
    typescript-language-server
    vscode-extensions.vscjava.vscode-java-test
    yaml-language-server # YAML language server
    yq
    tectonic # LaTeX rendering for snacks.image
  ]
  ++ lib.optionals pkgs.stdenv.isDarwin [
    pngpaste # required by img-clip.nvim on macOS
  ];

  programs.neovim = {
    enable = true;
    # package = inputs.neovim-nightly-overlay.packages.${system}.default;
    defaultEditor = true;
    coc.enable = false;
    vimAlias = true;
    withRuby = false;
    withPython3 = true;
    # Our init.lua comes from ./nvim, so load home-manager's generated init
    # (python3_host_prog, etc.) via the wrapper instead of writing init.lua.
    sideloadInitLua = true;
    extraLuaPackages = ps: [ps.magick];
    extraPackages = [pkgs.imagemagick];
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
