{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "services.swww";

  options = {myconfig, ...}: {
    services.swww = with delib; {
      enable = boolOption (myconfig.wallpapers.wallpaperDaemon == "swww");
    };
  };

  myconfig.ifEnabled.services.wallpaper-manager.wantedService = "swww.service";

  home.ifEnabled = {
    home.packages = [pkgs.swww];

    systemd.user.services.swww = {
      Install = {WantedBy = ["graphical-session.target"];};

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "swww";
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
      };

      Service = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        ExecStop = "${pkgs.swww}/bin/swww kill";
        Restart = "always";
        RestartSec = "10";
      };
    };
  };
}
