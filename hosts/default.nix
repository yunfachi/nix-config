{
  specialArgs,
  isNixOS,
  ...
}: let
  username = "${specialArgs.username}";
  mkHost = host: type: let
    lib = specialArgs.inputs.nixpkgs.lib;
    home-manager = specialArgs.inputs.home-manager;
    nixpkgs = specialArgs.inputs.nixpkgs;
  in
    if isNixOS
    then
      lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./${host}
          ../modules/${type}
          ../options/${type}
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = lib.mkForce true;
              useGlobalPkgs = lib.mkForce true;

              extraSpecialArgs = specialArgs;
              users."${username}" = {
                imports = [
                  ../home/${type}
                ];
              };
            };
          }
        ];
      }
    else
      home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = specialArgs;
        pkgs = import nixpkgs {config.allowUnfree = lib.mkForce true;};
        modules = [
          ../home/${type}
        ];
      };
in
  builtins.listToAttrs (builtins.attrValues (builtins.mapAttrs (host: type: {
      name =
        if isNixOS
        then host
        else "${username}@${host}";
      value = mkHost host type;
    }) {
      "dekomori" = "desktop";
    }))
