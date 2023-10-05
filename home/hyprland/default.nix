{
  pkgs,
  hyprland,
  hyprsome,
  ...
}: {
  imports = [
    ./anyrun.nix
    ./wayland-apps.nix
  ];

  home.file.".config/hypr" = {
    source = ./hypr-conf;
    recursive = true;
  };

  home.packages = [
    hyprsome.packages.x86_64-linux.default
  ];

  fonts.fontconfig.enable = true;

  systemd.user.sessionVariables = {
    "NIXOS_OZONE_WL" = "1";
    "MOZ_ENABLE_WAYLAND" = "1";
    "MOZ_WEBRENDER" = "1";
  };
}
