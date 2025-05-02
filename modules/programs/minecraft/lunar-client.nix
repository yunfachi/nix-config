{
  delib,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "programs.minecraft";

  options.programs.minecraft = with delib; {
    enableLunarClient = boolOption true;
  };

  myconfig.ifEnabled = {cfg, ...}: {
    persist.user.directories = lib.mkIf cfg.enableLunarClient [".lunarclient"];
  };

  home.ifEnabled = {cfg, ...}: {
    home.packages = lib.mkIf cfg.enableLunarClient [pkgs.lunar-client];
  };
}
