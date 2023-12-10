{
  config,
  lib,
  type,
  ...
}: let
  cfg = config.yunfachi-nixos;
in {
  options.yunfachi-nixos = {
    hyprland.enable = lib.mkEnableOption "hyprland (nixos)" // {default = type == "desktop";};
  };
}
