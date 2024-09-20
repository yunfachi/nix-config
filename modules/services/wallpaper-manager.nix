{
  delib,
  pkgs,
  inputs,
  lib,
  ...
}:
delib.module {
  name = "services.wallpaper-manager";

  options = {
    myconfig,
    cfg,
    ...
  }: {
    services.wallpaper-manager = with delib; {
      enable = boolOption (cfg.wallpaperDaemon != null);

      wallpaperDaemon = allowNull (strOption myconfig.wallpapers.wallpaperDaemon);
      wantedService = noDefault (strOption null);
    };
  };

  home.always = {cfg, ...}: {
    assertions = [
      {
        assertion = !(cfg.enable && cfg.wallpaperDaemon == null);
        message = "services.wallpaper-manager.wallpaperDaemon cannot be null if wallpaper-manager is enabled";
      }
    ];
  };

  home.ifEnabled = {
    myconfig,
    cfg,
    ...
  }: {
    home.packages = [inputs.wallpaper-manager.packages.${pkgs.system}.default];

    systemd.user.services.wallpaper-manager = let
      package = inputs.wallpaper-manager.packages.${pkgs.system}.default;
    in {
      Install = {WantedBy = [cfg.wantedService];};

      Unit = {
        Description = "wallpaper-manager";
        After = [cfg.wantedService];
        BindsTo = [cfg.wantedService];
        PartOf = [cfg.wantedService];
      };

      Service = {
        ExecStart = "${lib.getExe package} start --dir ${myconfig.wallpapers.imagesDir} --interval ${toString myconfig.wallpapers.interval} --wallpaper-daemon ${cfg.wallpaperDaemon}";
        Restart = "always";
        RestartSec = "10";
      };
    };
  };
}
