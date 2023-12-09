{
  config,
  lib,
  ...
}: let
  cfg = config.yunfachi-nixos;
in {
  options.yunfachi-nixos = {
    hyprland.enable = lib.mkEnableOption "hyprland (nixos)" // {default = true;};
  };
}
