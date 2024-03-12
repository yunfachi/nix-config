{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nypkgs = {
      url = "github:yunfachi/nypkgs/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nypkgs,
    nix-vscode-extensions,
  }: let
    constants = import ./constants.nix;
    system = "x86_64-linux";

    packages = rec {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;

      ypkgs = nypkgs.legacyPackages.${system};
      ylib = ypkgs.lib;

      vscode-extensions = nix-vscode-extensions.extensions.${system}.vscode-marketplace;
    };

    lib = {
      module-functions = config:
        import ./lib/module-functions.nix {
          inherit (packages) lib;
          inherit (constants) username;
          inherit config;
        };
      option-functions = config:
        import ./lib/option-functions.nix {
          inherit (packages) lib;
          inherit (constants) username;
          inherit config;
        };
    };

    specialArgs =
      {
        inherit system;
      }
      // constants
      // packages
      // lib;
  in {
    nixosConfigurations = import ./hosts {
      inherit (packages) lib ylib;
      inherit (self) nixosConfigurations;
      inherit home-manager nypkgs;
      inherit specialArgs;
    };

    devShells.${system}.default = with packages.pkgs;
      mkShell {
        packages = [
          git
          statix
          deadnix
        ];
      };
  };
}
