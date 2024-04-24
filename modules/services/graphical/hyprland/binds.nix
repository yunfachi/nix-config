{
  module-functions,
  hm,
  lib,
  ...
}:
module-functions.module "services" "hyprland" {
  hm.wayland.windowManager.hyprland.settings = {
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bindi = [
      ", mouse:276, exec, ~/.config/hypr/scripts/clicker.sh 1"
      ", mouse:275, exec, ~/.config/hypr/scripts/clicker.sh 3"
    ];

    bind =
      [
        "$mod, q, killactive,"
        "CTRLALT, Delete, exit,"

        "$mod, Return, exec, $terminal"

        "$mod, v, togglefloating"
        "$mod, m, pseudo"
        "$mod, j, togglesplit"

        "$mod, TAB, cyclenext"
        "$mod, TAB, bringactivetotop"

        "$mod, s, exec, ~/.config/hypr/scripts/screenshot.sh screen"
        "$mod SHIFT, s, exec, ~/.config/hypr/scripts/screenshot.sh area"
      ]
      ++ builtins.concatMap (_workspace: let
        key = builtins.toString (lib.mod _workspace 10);
        workspace = builtins.toString _workspace;
      in [
        "$mod, ${key}, split-workspace, ${workspace}"
        "$mod SHIFT, ${key}, split-movetoworkspacesilent, ${workspace}"
      ]) (lib.range 1 10);
  };
}
