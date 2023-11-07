{
  description = "yunfachi's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
    username = "yunfachi";
    userfullname = "Yun Fachi";
    useremail = "yunfachi@gmail.com";

    nixosSystem = import ./lib/nixosSystem.nix;
    nixosVersion = "23.11";

    specialArgs =
      {
        inherit username userfullname useremail;
        inherit nixosVersion;
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
    ];

    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
