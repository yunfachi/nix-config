{
  config,
  lib,
  type,
  ...
}:
with lib; let
  cfg = config.yunfachi-nixos;
in {
  options.yunfachi-nixos = {
    hyprland.enable = mkEnableOption "hyprland" // {default = type == "desktop";};
  };
}
