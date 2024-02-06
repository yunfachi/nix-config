{
  module-functions,
  hm,
  config,
  pkgs,
  lib,
  ...
}:
module-functions.module "services" "hyprland" {
  hm.wayland.windowManager.hyprland.settings = {
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    bind =
      [
        "$mod, q, killactive,"
        "CTRLALT, Delete, exit,"

        "$mod, Return, exec, $terminal"

        "$mod, v, togglefloating"
        "$mod, p, pseudo"
        "$mod, j, togglesplit"

        "$mod, TAB, cyclenext"
        "$mod, TAB, bringactivetotop"
      ]
      ++ builtins.concatMap (_workspace: let
        key = builtins.toString (lib.mod _workspace 10);
        workspace = builtins.toString _workspace;
      in [
        "$mod, ${key}, workspace, ${workspace}"
        "$mod SHIFT, ${key}, movetoworkspacesilent, ${workspace}"
      ]) (lib.range 1 10);
  };
}
