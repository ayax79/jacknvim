{
  description = "Jack's Neovim configuration";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # Only used by checks to evaluate the module
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    systems = ["aarch64-darwin" "x86_64-linux"];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
  in {
    homeManagerModules = {
      default = self.homeManagerModules.jacknvim;
      jacknvim = {
        lib,
        pkgs,
        ...
      }: {
        imports = [./module.nix];
        # vim.pack requires neovim 0.12+
        programs.neovim.package =
          lib.mkDefault inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    };

    formatter = forAllSystems (pkgs: pkgs.alejandra);

    checks = forAllSystems (pkgs: {
      # Evaluates the module without building the (large) home-manager closure
      module-eval = let
        hm = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            self.homeManagerModules.default
            {
              home.username = "test";
              home.homeDirectory = "/tmp/test";
              home.stateVersion = "25.05";
            }
          ];
        };
        drvPath = builtins.unsafeDiscardStringContext hm.activationPackage.drvPath;
      in
        pkgs.runCommand "jacknvim-module-eval" {} ''
          echo ${drvPath} > $out
        '';
    });
  };
}
