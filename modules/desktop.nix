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
}
