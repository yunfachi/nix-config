{
  delib,
  inputs,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.ags";

  options.programs.ags = with delib; {
    enable = boolOption host.isDesktop;

    configPackage = noDefault (packageOption null);
  };

  home.always.imports = [inputs.ags.homeManagerModules.default];

  home.ifEnabled = {cfg, ...}: {
    programs.ags = {
      enable = true;

      configDir = cfg.configPackage;
      systemd.enable = true;

      extraPackages = with pkgs; [
      ];
    };
  };
}
