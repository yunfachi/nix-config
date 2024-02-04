{
  lib,
  ylib,
  nixosConfigurations,
  home-manager,
  specialArgs,
}: let
  hosts = builtins.attrNames (lib.filterAttrs (name: type: type == "directory") (builtins.readDir ./.));

  host = name: let
    extraSpecialArgs =
      specialArgs
      // {
        host = nixosConfigurations.${name}.config.host;
        module-functions = specialArgs.module-functions nixosConfigurations.${name}.config;
        option-functions = specialArgs.option-functions nixosConfigurations.${name}.config;
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
