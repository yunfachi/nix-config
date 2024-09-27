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
      };

      decoration = {
        rounding = cfg.border.radius;
        screen_shader = lib.mkIf (cfg.shader != null) (toString cfg.shader);

        drop_shadow = cfg.shadow.enable;
        shadow_range = cfg.shadow.range;
        shadow_render_power = cfg.shadow.power;
        shadow_offset = cfg.shadow.offset;
        shadow_scale = cfg.shadow.scale;
        "col.shadow" = cfg.shadow.color;
        "col.shadow_inactive" = lib.mkIf (cfg.shadow.inactive_color != null) cfg.shadow.inactive_color;
      };

      input = {
        kb_layout = "us"; # fcitx5
        kb_options = "";
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
      };

      cursor = {};

      dwindle.preserve_split = true;

      exec-once = map (x: (pkgs.writeShellScript "commands-windowManager-onStartup-map.sh" x).outPath) myconfig.commands.windowManager.onStartup;
      exec = map (x: (pkgs.writeShellScript "commands-windowManager-onReload-map.sh" x).outPath) myconfig.commands.windowManager.onReload;
    };
  };
}
