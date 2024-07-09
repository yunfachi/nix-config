{
  module-functions,
  config,
  pkgs,
  host,
  ...
}:
module-functions.module "programs" "eww" {
  yunfachi.programs.eww.config."scripts/active-workspace.sh" =
    if host.window-manager == "hyprland"
    then ''
      #!${pkgs.bash}

      hyprctl monitors -j | ${pkgs.jq}/bin/jq '.[] | select(.focused) | .activeWorkspace.id'

      ${pkgs.socat}/bin/socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
        stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}'
    ''
    else "";
}
