{
  module-functions,
  hm,
  config,
  pkgs,
  ...
}:
module-functions.module "services" "hyprland" {
  hm.wayland.windowManager.hyprland.settings = let
    #TODO: move this to the options something like rice.nix&terminal.nix
    mod = "SUPER";
    terminal =
      if config.yunfachi.programs.kitty.enable
      then "${pkgs.kitty}/bin/kitty"
      else "${pkgs.xterm}/bin/xterm";
  in {
    "$mod" = mod;
    "$terminal" = terminal;

    general = {
      border_size = 2;
      gaps_in = 4;
      gaps_out = 8;
      #TODO: move all colors to a separate module
      "col.inactive_border" = "0xAE776B5D";
      "col.active_border" = "0xFF776B5D";
    };

    decoration = {
      rounding = 8;
    };

    input = {
      kb_layout = config.services.xserver.layout;
      kb_options = config.services.xserver.xkbOptions;
    };

    dwindle = {
      preserve_split = true;
    };

    exec-once = [
      "$terminal"
    ];
  };
}
