{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "services" "hyprland" {
  hm.xdg.configFile."hypr/scripts/screenshot.sh" = {
    executable = true;
    text = ''
      ${pkgs.grimblast}/bin/grimblast copysave $1 &
      pids=$(pgrep -f "slurp" | grep -v "$!" | xargs)

      [[ -z "$pids" ]] || kill $pids

    '';
  };
}
