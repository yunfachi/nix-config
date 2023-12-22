{
  config,
  lib,
  type,
  ...
}: let
  cfg = config.yunfachi-nixos;
in {
  options.yunfachi-nixos = {
    archisteamfarm.enable = lib.mkEnableOption "archisteamfarm" // {default = false;};
    hyprland.enable = lib.mkEnableOption "hyprland (nixos)" // {default = type == "desktop";};
  };
}
