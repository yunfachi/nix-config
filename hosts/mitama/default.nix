{nixosVersion, ...}: {
  imports = [
    ./hardware.nix

    ../../modules/server.nix
  ];

  networking = {
    hostName = "mitama";
  };
}
