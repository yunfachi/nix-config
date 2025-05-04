{
  delib,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "programs.minecraft";

  options.programs.minecraft = with delib; {
    enablePrismLauncher = boolOption true;
  };

  myconfig.ifEnabled = {cfg, ...}: {
    persist.user.directories = lib.mkIf cfg.enablePrismLauncher [".local/share/PrismLauncher"];
  };

  home.ifEnabled = {cfg, ...}: {
    home.packages = lib.mkIf cfg.enablePrismLauncher [pkgs.prismlauncher];
  };
}
