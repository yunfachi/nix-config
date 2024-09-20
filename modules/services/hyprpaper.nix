{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "services.hyprpaper";

  options = {myconfig, ...}: {
    services.hyprpaper = with delib; {
      enable = boolOption (myconfig.wallpapers.wallpaperDaemon == "hyprpaper");
    };
  };

  myconfig.ifEnabled.services.wallpaper-manager.wantedService = "hyprpaper.service";

  home.ifEnabled = {
    home.packages = [pkgs.hyprpaper];

    services.hyprpaper = {
      enable = true;

      settings.splash = false;
    };
  };
}
