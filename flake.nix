{
  description = "yunfachi's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-yunfachi = {
      url = "github:yunfachi/nixpkgs-yunfachi/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-yunfachi,
    home-manager,
    ...
  } @ inputs: let
    username = "yunfachi";
    userfullname = "Yun Fachi";
    useremail = "yunfachi@gmail.com";

    nixosSystem = import ./lib/nixosSystem.nix;
    nixosVersion = "23.11";

    specialArgs =
      {
        inherit username userfullname useremail;
        inherit nixosVersion;
        pkgs-yunfachi = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          overlays = [
            inputs.nixpkgs-yunfachi.overlays.default
          ];
        };
      }
      // inputs;

    dekomori_modules = {
      host = ./hosts/dekomori;
      home = ./home/desktop.nix;
    };
    mitama_modules = {
      host = ./hosts/mitama;
      home = ./home/server.nix;
    };
  in {
    nixosConfigurations = let
      args = {
        inherit nixpkgs home-manager;
        system = "x86_64-linux";
        specialArgs = specialArgs;
      };
    in {
      dekomori = nixosSystem (dekomori_modules // args);
      mitama = nixosSystem (mitama_modules // args);
    };
  };

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];

    substituters = [
      "https://cache.nixos.org"
      "https://ezkea.cachix.org" # https://github.com/ezKEa/aagl-gtk-on-nix
    ];

    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" # https://github.com/ezKEa/aagl-gtk-on-nix
    ];
  };
}
