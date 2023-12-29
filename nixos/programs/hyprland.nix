{
  config,
  inputs,
  lib,
  pkgs,
  system,
  ...
}: let
  cfg = config.yunfachi.hyprland;
in {
  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      portalPackage = inputs.xdph.packages.${system}.xdg-desktop-portal-hyprland;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
