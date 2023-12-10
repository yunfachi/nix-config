{
  specialArgs,
  isNixOS,
  ...
}: let
  username = specialArgs.username;

  lib = specialArgs.inputs.nixpkgs.lib;
  home-manager = specialArgs.inputs.home-manager;
  nixpkgs = specialArgs.inputs.nixpkgs;
  mkHost = host: let
    nixosModules = [
      ./${host}/hardware.nix

      ./${host}/nixos.nix
      ../options/nixos
      ../nixos
    ];
    homeModules = [
      ./${host}/home.nix
      ../options/home
      ../home
    ];
    type = import ./${host}/type.nix;
    extraSpecialArgs =
      {
        inherit type host isNixOS;
      }
      // specialArgs;
  in
    if isNixOS
    then
      lib.nixosSystem {
        specialArgs = extraSpecialArgs;
        modules =
          nixosModules
          ++ [
            (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" username])
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                inherit extraSpecialArgs;

                useUserPackages = lib.mkForce true;
                useGlobalPkgs = lib.mkForce true;

                users."${username}" = {
                  imports = homeModules;
                };
              };
            }
          ];
      }
    else
      home-manager.lib.homeManagerConfiguration {
        inherit extraSpecialArgs;

        pkgs = import nixpkgs {
          config.allowUnfree = lib.mkForce true;
        };
        modules = homeModules;
      };
in
  builtins.listToAttrs (builtins.attrValues (builtins.mapAttrs (host: value: {
    name =
      if isNixOS
      then host
      else "${username}@${host}";
    value = mkHost host;
  }) (builtins.removeAttrs (builtins.readDir ./.) ["default.nix"])))
