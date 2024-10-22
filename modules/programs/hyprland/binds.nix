{
  delib,
  lib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.hyprland";

  home.ifEnabled = {myconfig, ...}: {
    home.packages = [pkgs.hyprshot];

    wayland.windowManager.hyprland.settings = {
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind =
        lib.optional myconfig.programs.fcitx5.enable ''
          $mod SHIFT, Space, exec, if [[ "$(fcitx5-remote --check)" -eq "1" ]]; then fcitx5-remote -e; else fcitx5 -d --replace; fi
        ''
        ++ [
          "$mod, q, killactive,"
          "CTRLALT, Delete, exit,"

          "$mod, Return, exec, kitty"
          "$mod SHIFT, Return, exec, kitty --title noswallow"

          "$mod, v, togglefloating"
          "$mod, m, pseudo"
          "$mod, j, togglesplit"
          "$mod SHIFT, j, swapsplit"
          "$mod, f, fullscreen"
          "$mod, p, pin"

          "$mod SHIFT, n, split:grabroguewindows" # Finds all windows that are in invalid workspaces and moves them to the current workspace.

          "$mod, Tab, cyclenext"
          "$mod, Tab, bringactivetotop"

          "$mod, s, exec, pkill -c slurp; hyprshot --mode output --mode active"
          "$mod SHIFT, s, exec, pkill -c slurp; hyprshot --mode region --freeze"
        ]
        ++ builtins.concatMap (x: [
          "$mod, ${toString (lib.mod x 10)}, split:workspace, ${toString x}"
          "$mod SHIFT, ${toString (lib.mod x 10)}, split:movetoworkspacesilent, ${toString x}"
        ]) (lib.range 1 10)
        ++ lib.optional (builtins.length host.displays == 2) "$mod, n, split:swapactiveworkspaces, ${(builtins.elemAt host.displays 0).name} ${(builtins.elemAt host.displays 1).name}";
    };
  };
}
