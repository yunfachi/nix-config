{
  delib,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "programs.minecraft";

  myconfig.ifEnabled = {cfg, ...}: {
    persist.user.directories = lib.mkIf cfg.enableModrinthApp [".local/share/ModrinthApp"];
  };

  home.ifEnabled = {cfg, ...}: {
    home.packages = lib.mkIf cfg.enableModrinthApp [pkgs.modrinth-app];
  };
}
