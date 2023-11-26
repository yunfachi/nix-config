{
  description = "yunfachi's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
    inherit (self) outputs;
    username = "yunfachi";
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs outputs;
      inherit username system;
    };
  in {
    nixosConfigurations.dekomori = nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      modules = [
        ./hosts/dekomori
        ./modules/desktop

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users."${username}" = ./home/desktop;
        }
      ];
    };
  };
}
