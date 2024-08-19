{
  delib,
  lib,
  config,
  ...
}:
delib.module {
  name = "user";

  nixos.always = {myconfig, ...}: let
    inherit (myconfig.constants) username;
  in {
    imports = [(lib.mkAliasOptionModule ["user"] ["users" "users" config.myconfig.constants.username])];

    users = {
      groups.${username} = {};

      users.${username} = {
        isNormalUser = true;
        initialPassword = username;
        extraGroups = ["wheel"];
      };
    };
  };
}
