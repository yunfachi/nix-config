{
  config,
  lib,
  pkgs,
  umport,
  inputs,
  system,
  ...
}: let
  cfg = config.yunfachi.hyprland;
in {
  imports = umport {path = ./.;};

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        cliphist
        wl-clipboard
      ];
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${system}.hyprland;

      settings = lib.mkMerge [
        {
          monitor =
            map (
              m: let
                resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
                position = "${toString m.x}x${toString m.y}";
              in "${m.name},${resolution},${position},${toString m.scale}"
            )
            config.yunfachi.monitors;

          input = {
            kb_layout = "${
              if config.yunfachi.canary.enable
              then "canary"
              else "us"
            },ru";
            kb_options = "grp:win_space_toggle";
            follow_mouse = 1;
          };

          "$mod" = "SUPER";
          "$term" = "${pkgs.kitty}/bin/kitty";

          general = let
            gap = 8;
          in {
            gaps_in = gap;
            gaps_out = gap;
            layout = "dwindle";
          };

          misc = {
            disable_hyprland_logo = true;
          };

          exec-once = [
            "wl-paste --watch cliphist store"
          ];
        }
      ];
    };
  };
}
