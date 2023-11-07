{
  lib,
  nixosVersion,
  ...
}: {
  imports = [
    ./user.nix
  ];

  boot = {
    loader.grub.enable = false;
    tmp.cleanOnBoot = true;
  };

  documentation = {
    enable = lib.mkDefault false;
    doc.enable = lib.mkDefault false;
    info.enable = lib.mkDefault false;
    man.enable = lib.mkDefault false;
    nixos.enable = lib.mkDefault false;
  };

  system.stateVersion = nixosVersion;
}
