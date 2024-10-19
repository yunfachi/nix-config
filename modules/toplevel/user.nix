{
  delib,
  lib,
  config,
  decryptSecretFile,
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
        hashedPasswordFile = decryptSecretFile "user/hashedPassword";
        extraGroups = ["wheel"];
      };
    };
  };
}
