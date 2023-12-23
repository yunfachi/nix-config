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
    config = specialArgs.self.nixosConfigurations."${host}".config;

    nixosModules = [
      ./${host}/hardware.nix

      ../nixos
    ];
    homeModules = [
      ./${host}/config.nix
      ../options
      ../home
    ];

    extraSpecialArgs =
      {
        inherit host isNixOS;
        type = config.yunfachi.type;
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
            (lib.mkAliasOptionModule ["yunfachi"] ["hm" "yunfachi"])
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
        inherit (extraSpecialArgs.pkgs) pkgs;

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
