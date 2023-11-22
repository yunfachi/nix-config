{pkgs, ...}: {
  imports = [
    ./core.nix
  ];

  # Get system’s power information such as cpu usage.
  services.upower.enable = true;
  systemd.services.upower.enable = true;

  # Communication between multiple processes running concurrently on the system.
  services.dbus = {
    enable = true;
    packages = [pkgs.dconf];
  };

  # Sounds
  services.pipewire = {
    enable = true;
    package = pkgs.pipewire;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  security.rtkit.enable = true;
  sound.enable = false;
  hardware.pulseaudio.enable = false;
}
