{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    flatpak.enable = true;

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

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
  };
}
