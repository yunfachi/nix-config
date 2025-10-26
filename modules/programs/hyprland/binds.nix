{
  delib,
  lib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.hyprland";

  home.ifEnabled =
    { myconfig, ... }:
    {
      home.packages = with pkgs; [
        hyprshot
        brightnessctl
      ];

      wayland.windowManager.hyprland.settings = {
        binds = {
          scroll_event_delay = 0;
        };

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        bindit = [
          ", mouse:276, exec, ~/.config/hypr/scripts/clicker.sh 1"
          ", mouse:275, exec, ~/.config/hypr/scripts/clicker.sh 3"
        ];

        bind =
          lib.optional myconfig.programs.fcitx5.enable ''
            $mod SHIFT, Space, exec, if [[ "$(fcitx5-remote --check)" -eq "1" ]]; then fcitx5-remote -e; else fcitx5 -d --replace; fi
          ''
          ++ lib.optional myconfig.programs.hyprlock.enable ''
            $mod, l, exec, hyprlock
          ''
          ++ lib.optional myconfig.programs.rofi.enable ''
            $mod, a, exec, rofi -modi "drun,calc" -show drun -show-icons -sidebar-mode
          ''
          ++ lib.optional myconfig.programs.rofi-rbw.enable ''
            $mod SHIFT, p, exec, rofi-rbw --action copy
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

            "$mod, mouse_down, exec, brightnessctl s 1%-"
            "$mod, mouse_up, exec, brightnessctl s +1%"
            ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 1%+"
            ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
          ]
          ++ builtins.concatMap (x: [
            "$mod, ${toString (lib.mod x 10)}, split:workspace, ${toString x}"
            "$mod SHIFT, ${toString (lib.mod x 10)}, split:movetoworkspacesilent, ${toString x}"
          ]) (lib.range 1 10)
          ++
            lib.optional (builtins.length host.displays == 2)
              "$mod, n, split:swapactiveworkspaces, ${(builtins.elemAt host.displays 0).name} ${(builtins.elemAt host.displays 1).name}";
      };
    };
}
