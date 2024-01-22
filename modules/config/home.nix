{
  home-manager,
  username,
  lib,
  ...
}: {
  imports = [
    (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" username])
  ];

  home-manager = {
    users."${username}" = {
      home.stateVersion = "24.05";
    };
  };
}
