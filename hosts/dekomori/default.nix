{nixosVersion, ...}: {
  imports = [
    ./hardware.nix

    ../../modules/desktop.nix
  ];

  networking = {
    hostName = "dekomori";
  };
}
