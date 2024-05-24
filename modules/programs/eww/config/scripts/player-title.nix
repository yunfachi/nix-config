{
  module-functions,
  pkgs,
  ...
}:
module-functions.module "programs" "eww" {
  yunfachi.programs.eww.config."scripts/player-title.sh" = ''
    ${pkgs.playerctl}/bin/playerctl -F metadata title
  '';
}
