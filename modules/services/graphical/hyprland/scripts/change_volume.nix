{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "services" "hyprland" {
  hm.xdg.configFile."hypr/scripts/change_volume.sh" = {
    executable = true;
    text = ''
      ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ "$1"
    '';
  };
}
