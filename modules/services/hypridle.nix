{
  delib,
  host,
  lib,
  ...
}:
delib.module {
  name = "services.hypridle";

  options = delib.singleEnableOption host.isDesktop;

  home.ifEnabled = {myconfig, ...}: {
    services.hypridle = {
      enable = true;

      settings = {
        general = {
          lock_cmd = lib.mkIf myconfig.programs.hyprlock.enable "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = lib.mkIf myconfig.programs.hyprland.enable "hyprctl dispatch dpms on";
        };

        listener =
          [
            {
              timeout = 25 * 60;
              on-timeout = "loginctl lock-session";
            }
          ]
          ++ lib.optional myconfig.programs.hyprland.enable {
            timeout = 30 * 60;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          };
      };
    };
  };
}
