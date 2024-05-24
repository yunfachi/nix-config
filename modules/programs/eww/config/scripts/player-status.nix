{
  module-functions,
  pkgs,
  ...
}:
module-functions.module "programs" "eww" {
  yunfachi.programs.eww.config."scripts/player-status.sh" = ''
    ${pkgs.playerctl}/bin/playerctl -F status
  '';
}
