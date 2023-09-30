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
    # Personal variables #
    #-=-=-=-=-=-=-=-=-=-=#
    username = "yunfachi";
    userfullname = "yunfachi";
    useremail = "yunfachi@gmail.com";

    #=-=-=-=-=-=-=-=-=-#
    # System variables #
    #-=-=-=-=-=-=-=-=-=#
    nixosVersion = "23.05";
    x64_system = "x86_64-linux";
    allSystems = [x64_system];
    nixosSystem = import ./lib/nixosSystem.nix;

    #=-=-=-=-=-=-=-=-=-=#
    # Special arguments #
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
    # Hosts modules #
    #-=-=-=-=-=-=-=-#
    mitama_modules = {
      modules = [
        ./hosts/mitama
        ./modules/hyprland.nix
      ];
      home = import ./home/desktop.nix;
    };
  in {
    nixosConfiguration = let
      #=-=-=-=-=-=-=-=-=#
      # NixOS arguments #
      #-=-=-=-=-=-=-=-=-#
      nixosArgs = {
        inherit home-manager;
        nixpkgs = nixpkgs-unstable; # pkgs branch [nixpkgs|nixpkgs-unstable]
        system = x64_system;
        specialArgs = x64_specialArgs;
      };
    in {
      #=-=-=-=-=-=-=-=#
      # Hosts systems #
      #-=-=-=-=-=-=-=-#
      mitama = nixosSystem (mitama_modules // nixosArgs);
    };

    #=-=-=-=-=-=-=-=-=-=-=#
    # Alejandra formatter #
    #-=-=-=-=-=-=-=-=-=-=-#
    formatter = nixpkgs.lib.genAttrs allSystems (
      system: nixpkgs.legacyPackages.${system}.alejandra
    );
  };

  inputs = {
    #=-=-=-=-=-=-=-=-=-=-=#
    # System repositories #
    #-=-=-=-=-=-=-=-=-=-=-#
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #=-=-=-=-=-=-=-=-=-=-=-=#
    # Hyprland repositories #
    #-=-=-=-=-=-=-=-=-=-=-=-#
    hyprland.url = "github:hyprwm/Hyprland";

    #=-=-=-=-=-=-=-=-=-=-#
    # Other repositories #
    #-=-=-=-=-=-=-=-=-=-=#
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    #=-=-=-=-=-=-=-=-=-#
    # Own repositories #
    #-=-=-=-=-=-=-=-=-=#
    secrets = {
      url = "git+ssh://git@github.com/yunfachi/nix-secrets.git?shallow=1";
      flake = false;
    };
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
    ];

    extra-substituters = [
      "https://nix-community.cachix.org"
    ];

    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
