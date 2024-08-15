{
  home-manager,
  username,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" username])
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "hmbackup";

    users."${username}" = {
      home.stateVersion = "24.11";
    };
  };
}
