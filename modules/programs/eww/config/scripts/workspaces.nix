{
  module-functions,
  lib,
  config,
  hm,
  pkgs,
  host,
  ...
}:
module-functions.module "programs" "eww" {
  yunfachi.programs.eww.config."scripts/workspaces.sh" =
    if host.window-manager == "hyprland"
    then ''
      #!${pkgs.bash}

      spaces (){
      	WORKSPACE_WINDOWS=$(hyprctl workspaces -j | ${pkgs.jq}/bin/jq 'map({key: .id | tostring, value: .windows}) | from_entries')
      	seq 1 10 | ${pkgs.jq}/bin/jq --argjson windows "''${WORKSPACE_WINDOWS}" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)})'
      }

      spaces
      ${pkgs.socat}/bin/socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
      	spaces
      done
    ''
    else "";
}
