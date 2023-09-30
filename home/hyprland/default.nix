{
  pkgs,
  hyprland,
  ...
}: {
  home.file.".config/hypr" = {
    source = ./hypr-conf;
    recursive = true;
  };

  systemd.user.sessionVariables = {
    "NIXOS_OZONE_WL" = "1";
    "MOZ_ENABLE_WAYLAND" = "1";
    "MOZ_WEBRENDER" = "1";
  };
}
