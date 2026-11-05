# jacknvim

My Neovim configuration, packaged as a Nix flake that exports a home-manager
module. See [`nvim/README.md`](nvim/README.md) for details on the config itself.

## Usage

```nix
{
  inputs.jacknvim = {
    url = "github:ayax79/jacknvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # in homeManagerConfiguration modules:
  modules = [ inputs.jacknvim.homeManagerModules.default ];
}
```

The module:

- enables `programs.neovim` (nightly build from `neovim-nightly-overlay`,
  overridable via `programs.neovim.package`)
- installs LSP servers, formatters and debug adapters
- links `nvim/` to `~/.config/nvim`

## Local development

Test changes from a consuming flake without pushing:

```sh
home-manager switch --flake .#$(whoami)@$(hostname -s) --override-input jacknvim path:../jacknvim
```

## Checks

```sh
nix flake check   # evaluates the module
nix fmt           # alejandra
```
