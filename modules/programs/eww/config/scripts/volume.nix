{
  module-functions,
  pkgs,
  ...
}:
module-functions.module "programs" "eww" {
  yunfachi.programs.eww.config."scripts/volume.sh" = ''
    get_volume (){
      ${pkgs.pulseaudio}/bin/pactl get-sink-volume @DEFAULT_SINK@ | awk 'match($0, /([[:digit:]]*)%/){ print substr($0, RSTART, RLENGTH-1) }'
    }
    get_volume
    ${pkgs.pulseaudio}/bin/pactl subscribe | grep --line-buffered "sink" | while read -r UNUSED_LINE; do get_volume; done
  '';
}
