{
  config,
  lib,
  type,
  ...
}:
with lib; let
  cfg = config.yunfachi;
in {
  options.yunfachi = {
    audio.enable = lib.mkEnableOption "audio (pipewire)" // {default = type == "desktop";};

    grub.enable = lib.mkEnableOption "grub" // {default = true;};

    archisteamfarm.enable = mkEnableOption "archisteamfarm" // {default = false;};
  };
}
