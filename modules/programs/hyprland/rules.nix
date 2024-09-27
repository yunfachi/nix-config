{
  delib,
  lib,
  ...
}:
delib.module {
  name = "programs.hyprland";

  home.ifEnabled = {myconfig, ...}: {
    wayland.windowManager.hyprland.settings = {
      windowrule =
        [
        ]
        ++ lib.optional myconfig.programs.fcitx5.enable "pseudo,fcitx";
    };
  };
}
