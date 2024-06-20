{
  module-functions,
  pkgs,
  username,
  ...
}:
module-functions.module "programs" "eww" {
  yunfachi.programs.eww.config."scripts/clicker-state.sh" = ''
    ${pkgs.inotify-tools}/bin/inotifywait -m -e close_write "/home/${username}/.clicker.data" |
    while read -r filename event; do
      cat "/home/${username}/.clicker.data"
    done
  '';
}
