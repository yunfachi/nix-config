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
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nypkgs,
    nix-vscode-extensions,
    sops-nix,
  }: let
    constants = import ./constants.nix;
    system = "x86_64-linux";
    data = import ./data {inherit (nixpkgs) lib;};

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

    lib =
      import ./lib/lib.nix {
        inherit (packages) ylib;
        inherit (constants) username;
      }
      // {
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
        inherit system data;
      }
      // constants
      // packages
      // lib;
  in {
    nixosConfigurations = import ./hosts {
      inherit (packages) lib ylib;
      inherit (self) nixosConfigurations;
      inherit home-manager nypkgs sops-nix;
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
