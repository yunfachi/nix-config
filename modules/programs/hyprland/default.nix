{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.hyprland";

  options.programs.hyprland = with delib; {
    enable = boolOption host.guiFeatured;

    mod = strOption "SUPER";
    shader = allowNull (pathOption null);
    background_color = strOption "0x111111";

    gaps = {
      inner = intOption 5;
      outer = intOption 20;
    };

    border = {
      size = intOption 1;
      radius = intOption 0;
      inactive_color = strOption "0xff444444";
      active_color = strOption "0xffffffff";
    };

    shadow = {
      enable = boolOption true;
      range = intOption 4;
      power = intOption 3;
      offset = strOption "0 0";
      scale = floatOption 1.0;
      color = strOption "0xee1a1a1a";
      inactive_color = allowNull (strOption null);
    };
  };

  nixos.ifEnabled.programs.hyprland.enable = true;
  home.ifEnabled.wayland.windowManager.hyprland = {
    enable = true;

    plugins = [pkgs.hyprlandPlugins.hyprsplit];
  };
}
