{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    nixpkgs-yunfachi = {
      url = "github:yunfachi/nixpkgs-yunfachi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xdph = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-yunfachi,
    pre-commit-hooks,
    ...
  }: let
    constants = import ./constants.nix;

    system = "x86_64-linux";

    specialArgs =
      rec {
        inherit inputs self;
        inherit system;

        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        pkgs-yunfachi = import nixpkgs-yunfachi {inherit nixpkgs system;};

        umport = pkgs-yunfachi.umport;
      }
      // constants;

    eachSystem = object: (nixpkgs.lib.genAttrs [system] object);
  in {
    nixosConfigurations = import ./hosts (
      {inherit specialArgs;} // {isNixOS = true;}
    );

    homeConfigurations = import ./hosts (
      {inherit specialArgs;} // {isNixOS = false;}
    );

    checks = eachSystem (system: {
      pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
          statix = {
            enable = true;
            excludes = [".lock"];
          };
          prettier = {
            enable = false;
            excludes = [".md"];
          };
        };
      };
    });
  };
}
