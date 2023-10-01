{
  description = "kazhe pes 'ya ne lublyu mayonez gav gav' kazhe pes 'mozhe ketchyup v tebe est gav gav'";

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    #=-=-=-=-=-=-=-=-=-=-#
    # Personal Variables #
    #-=-=-=-=-=-=-=-=-=-=#
    username = "yunfachi";
    userfullname = "yunfachi";
    useremail = "yunfachi@gmail.com";

    #=-=-=-=-=-=-=-=-=-#
    # System Variables #
    #-=-=-=-=-=-=-=-=-=#
    nixosVersion = "23.05";
    x64_system = "x86_64-linux";
    allSystems = [x64_system];
    nixosSystem = import ./lib/nixosSystem.nix;

    #=-=-=-=-=-=-=-=-=-=#
    # Special Arguments #
    #-=-=-=-=-=-=-=-=-=-#
    x64_specialArgs =
      {
        inherit username userfullname useremail nixosVersion;
        pkgs-unstable = import nixpkgs-unstable {
          system = x64_system;
          # TODO: remove
          config.allowUnfree = true;
        };
      }
      // inputs;

    #=-=-=-=-=-=-=-=#
    # Hosts Modules #
    #-=-=-=-=-=-=-=-#
    mitama_modules = {
      modules = [
        ./hosts/mitama
        ./modules/hyprland.nix
      ];
      home = import ./home/desktop.nix;
    };
  in {
    nixosConfigurations = let
      #=-=-=-=-=-=-=-=-=#
      # NixOS Arguments #
      #-=-=-=-=-=-=-=-=-#
      nixosArgs = {
        inherit home-manager;
        nixpkgs = nixpkgs-unstable; # pkgs branch [nixpkgs|nixpkgs-unstable]
        system = x64_system;
        specialArgs = x64_specialArgs;
      };
    in {
      #=-=-=-=-=-=-=-=#
      # Hosts Systems #
      #-=-=-=-=-=-=-=-#
      mitama = nixosSystem (mitama_modules // nixosArgs);
    };

    #=-=-=-=-=-=-=-=-=#
    # Custom Packages #
    #-=-=-=-=-=-=-=-=-#
    packages = nixpkgs.lib.genAttrs allSystems (
      system: import ./pkgs nixpkgs.legacyPackages.${system}
    );

    #=-=-=-=-=-=-=-=-=-=-=#
    # Alejandra Formatter #
    #-=-=-=-=-=-=-=-=-=-=-#
    formatter = nixpkgs.lib.genAttrs allSystems (
      system: nixpkgs.legacyPackages.${system}.alejandra
    );
  };

  inputs = {
    #=-=-=-=-=-=-=-=-=-=-=#
    # System Repositories #
    #-=-=-=-=-=-=-=-=-=-=-#
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #=-=-=-=-=-=-=-=-=-=-=-=#
    # Hyprland Repositories #
    #-=-=-=-=-=-=-=-=-=-=-=-#
    hyprland.url = "github:hyprwm/Hyprland";
    hyprsome.url = "github:sopa0/hyprsome";

    #=-=-=-=-=-=-=-=-=-=-#
    # Other Repositories #
    #-=-=-=-=-=-=-=-=-=-=#
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #=-=-=-=-=-=-=-=-=-#
    # Own Repositories #
    #-=-=-=-=-=-=-=-=-=#
    #secrets = {
    #  url = "git+ssh://git@github.com/yunfachi/nix-secrets.git?shallow=1";
    #  flake = false;
    #};
    wallpapers = {
      url = "github:yunfachi/wallpapers";
      flake = false;
    };
  };

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];

    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
      "https://anyrun.cachix.org"
    ];

    extra-substituters = [
      "https://nix-community.cachix.org"
    ];

    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };
}
