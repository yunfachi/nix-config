{
  config,
  inputs,
  lib,
  pkgs,
  system,
  ...
}: let
  cfg = config.yunfachi-nixos.hyprland;
in {
  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      portalPackage = inputs.xdph.packages.${system}.xdg-desktop-portal-hyprland;
    };

    hm.wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${system}.hyprland;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
