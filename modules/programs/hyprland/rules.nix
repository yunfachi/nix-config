{
  delib,
  lib,
  ...
}:
delib.module {
  name = "programs.hyprland";

  home.ifEnabled = {myconfig, ...}: {
    wayland.windowManager.hyprland.settings = {
      windowrulev2 =
        [
        ]
        ++ lib.optional myconfig.programs.fcitx5.enable "pseudo, class:fcitx"
        ++ lib.optional myconfig.programs.nautilus.enable "float, class:org.gnome.NautilusPreviewer";
    };
  };
}
