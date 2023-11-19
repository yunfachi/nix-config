{nixosVersion, ...}: {
  imports = [
    ./hardware.nix

    ../../modules/desktop.nix
    ../../modules/xmonad.nix
  ];

  networking = {
    hostName = "dekomori";
  };
}
