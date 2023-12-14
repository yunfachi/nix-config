{
  config,
  lib,
  type,
  ...
}: let
  cfg = config.yunfachi-nixos;
in {
  options.yunfachi-nixos = {
    audio.enable = lib.mkEnableOption "audio (pipewire)" // {default = type == "desktop";};
  };
}
