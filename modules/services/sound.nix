{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "services" "sound" {
  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    #jack.enable = true;
  };
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
}
