{
  module-functions,
  pkgs,
  ...
}:
module-functions.module "programs" "eww" {
  yunfachi.programs.eww.config."scripts/player-playpause.sh" = ''
    ${pkgs.playerctl}/bin/playerctl play-pause
  '';
}
