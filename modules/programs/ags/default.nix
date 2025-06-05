{
  delib,
  inputs,
  pkgs,
  lib,
  host,
  homeconfig,
  ...
}:
delib.module {
  name = "programs.ags";

  options.programs.ags = with delib; {
    enable = boolOption host.guiFeatured;

    configPackage = noDefault (packageOption null);
  };

  myconfig.ifEnabled.services.gvfs.enable = true;

  home.always.imports = [inputs.ags.homeManagerModules.default];

  home.ifEnabled = {cfg, ...}: {
    home.packages = [inputs.astal.packages.${pkgs.system}.default cfg.configPackage];

    programs.ags = {
      enable = true;

      configDir = cfg.configPackage;
      systemd.enable = true;

      extraPackages = with inputs.ags.packages.${pkgs.system}; [
        hyprland
        mpris
        pkgs.imagemagick
      ];
    };

    systemd.user.services.ags.Service.Environment = [
      "PATH=${lib.makeBinPath (with pkgs; [
        imagemagick
      ])}"
      "XDG_CACHE_HOME=${homeconfig.xdg.cacheHome}"
    ];
  };
}
