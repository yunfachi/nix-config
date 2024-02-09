{
  lib,
  ylib,
  nixosConfigurations,
  home-manager,
  specialArgs,
}: let
  hosts = builtins.attrNames (lib.filterAttrs (name: type: type == "directory") (builtins.readDir ./.));

  host = name: let
    config = nixosConfigurations.${name}.config;

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
