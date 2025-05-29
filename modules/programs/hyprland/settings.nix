{
  delib,
  lib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.hyprland";

  home.ifEnabled = {
    cfg,
    myconfig,
    ...
  }: {
    wayland.windowManager.hyprland.settings = {
      "$mod" = cfg.mod;

      monitor =
        map (display: let
          resolution = "${toString display.width}x${toString display.height}@${toString display.refreshRate}";
          position = "${toString display.x}x${toString display.y}";
        in "${display.name},${
          if display.enable
          then "${resolution},${position},1"
          else "disable"
        }")
        host.displays;

      general = {
        gaps_in = cfg.gaps.inner;
        gaps_out = cfg.gaps.outer;

        border_size = cfg.border.size;
        "col.inactive_border" = cfg.border.inactive_color;
        "col.active_border" = cfg.border.active_color;

        snap = {
          enabled = true;
          window_gap = 10;
          monitor_gap = 10;
          border_overlap = true;
        };
      };

      plugin.hyprsplit = {
        num_workspaces = 10;
        persistent_workspaces = true;
      };

      decoration = {
        rounding = cfg.border.radius;
        screen_shader = lib.mkIf (cfg.shader != null) (toString cfg.shader);

        shadow = {
          inherit (cfg.shadow) range offset scale color;
          enabled = cfg.enable;
          render_power = cfg.shadow.power;
          color_inactive = lib.mkIf (cfg.shadow.inactive_color != null) cfg.shadow.inactive_color;
        };
      };

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:win_space_toggle";
        touchpad = {
          disable_while_typing = false;
          natural_scroll = true;
        };
      };

      misc = {
        disable_hyprland_logo = true; # (╥﹏╥)
        disable_splash_rendering = true;
        focus_on_activate = true;
        middle_click_paste = false;
        new_window_takes_over_fullscreen = 1;
        background_color = cfg.background_color;

        enable_swallow = true;
        swallow_regex = "^(kitty)$"; #FIXME: modules/config/terminal.nix
        swallow_exception_regex = "^(noswallow|nvim)$";

        anr_missed_pings = 5;
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      cursor = {};

      dwindle.preserve_split = true;

      exec-once = map (x: (pkgs.writeShellScript "commands-windowManager-onStartup-map.sh" x).outPath) myconfig.commands.windowManager.onStartup;
      exec = map (x: (pkgs.writeShellScript "commands-windowManager-onReload-map.sh" x).outPath) myconfig.commands.windowManager.onReload;
    };
  };
}
