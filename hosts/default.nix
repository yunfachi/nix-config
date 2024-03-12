{
  lib,
  ylib,
  nixosConfigurations,
  nypkgs,
  home-manager,
  specialArgs,
}: let
  hosts = builtins.attrNames (lib.filterAttrs (_name: type: type == "directory") (builtins.readDir ./.));

  host = name: let
    inherit (nixosConfigurations.${name}) config;

    extraSpecialArgs =
      specialArgs
      // {
        host = config.host;
        module-functions = specialArgs.module-functions config;
        option-functions = specialArgs.option-functions config;
      };
  in
    lib.nixosSystem {
      specialArgs = extraSpecialArgs;
      modules =
        [
          ./${name}
          ./${name}/hardware.nix
          nypkgs.nixosModules.nypkgs
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
            };
          }
          {
            host.name = name;
          }
        ]
        ++ ylib.umport {
          paths = [../modules ../options];
          recursive = true;
        };
    };
in
  builtins.listToAttrs (builtins.map (name: {
      inherit name;
      value = host name;
    })
    hosts)
