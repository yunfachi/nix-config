{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nypkgs = {
      url = "github:yunfachi/nixpkgs-yunfachi/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nypkgs,
  }: let
    constants = import ./constants.nix;
    system = "x86_64-linux";

    packages = rec {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;

      ypkgs = import nypkgs {
        inherit system;
      };
      ylib = ypkgs.lib;
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
      inherit home-manager;
      inherit specialArgs;
    };
  };
}
