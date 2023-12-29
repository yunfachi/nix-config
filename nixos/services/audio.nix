{
  config,
  lib,
  ...
}: let
  cfg = config.yunfachi.audio;
in {
  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
    };
    hardware.pulseaudio.enable = false;
  };
}
