{
  nixpkgs,
  home-manager,
  flatpak,
  system,
  specialArgs,
  host,
  home,
}: let
  username = specialArgs.username;
in
  nixpkgs.lib.nixosSystem {
    inherit system specialArgs;
    modules = [
      host

      {
        nix.registry.nixpkgs.flake = nixpkgs;

        environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
        nix.nixPath = ["/etc/nix/inputs"];
      }

      home-manager.nixosModules.home-manager
      {
        home-manager.sharedModules = [flatpak.homeManagerModules.default];

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.extraSpecialArgs = specialArgs;
        home-manager.users."${username}" = home;
      }
    ];
  }
