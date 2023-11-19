{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      layout = "us,ru";

      libinput = {
        enable = true;
      };

      displayManager.defaultSession = "none+xmonad";

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

      xkbOptions = "grp:win_space_toggle";
    };
  };
}
