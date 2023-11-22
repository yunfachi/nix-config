{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      enable = true;

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

      libinput.enable = true;

      displayManager.defaultSession = "none+xmonad";
      xkbOptions = "grp:win_space_toggle";
      layout = "us,ru";
    };
  };
}
