{
  module-functions,
  hm,
  config,
  pkgs,
  ylib,
  ...
}:
module-functions.module "services" "hyprland" (cfg: {
  hm.wayland.windowManager.hyprland.settings = let
    #TODO: move this to the options something like terminal.nix
    terminal =
      if config.yunfachi.programs.kitty.enable
      then "${pkgs.kitty}/bin/kitty"
      else "${pkgs.xterm}/bin/xterm";
  in {
    "$mod" = cfg.mod;
    "$terminal" = terminal;

    general = {
      border_size = config.yunfachi.rice.border_size;
      gaps_in = config.yunfachi.rice.gaps.inner;
      gaps_out = config.yunfachi.rice.gaps.outer;
      #TODO: move all colors to a separate module
      "col.inactive_border" = "0x99776B5D";
      "col.active_border" = "0xE6776B5D";
    };

    decoration = {
      rounding = config.yunfachi.rice.rounding;
    };

    input = {
      kb_layout = config.services.xserver.xkb.layout;
      kb_options = config.services.xserver.xkb.options;
    };

    monitor =
      map (m: let
        resolution = "${builtins.toString m.width}x${builtins.toString m.height}@${builtins.toString m.refreshRate}";
        position = "${builtins.toString m.x}x${builtins.toString m.y}";
      in "${m.id},${
        if m.enabled
        then "${resolution},${position},1"
        else "disable"
      }")
      config.yunfachi.hardware.displays;

    dwindle = {
      preserve_split = true;
    };

    exec-once = map (command: ylib.concatLinesWithSemicolon command) (
      [
        "$terminal"
      ]
      ++ config.yunfachi.commands.onGraphical.startup
      ++ cfg.commands.onStartup
    );
    exec = map (command: ylib.concatLinesWithSemicolon command) (
      [
      ]
      ++ config.yunfachi.commands.onGraphical.reload
      ++ cfg.commands.onReload
    );
  };
})
