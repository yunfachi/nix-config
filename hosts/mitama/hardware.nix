{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [];

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_blk"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/3b741fd9-3102-496a-b993-6685b8f4f722";
    fsType = "ext4";
  };

  fileSystems."/snap/snapd/20290" = {
    device = "/var/lib/snapd/snaps/snapd_20290.snap";
    fsType = "squashfs";
    options = ["loop"];
  };

  fileSystems."/snap/core20/2015" = {
    device = "/var/lib/snapd/snaps/core20_2015.snap";
    fsType = "squashfs";
    options = ["loop"];
  };

  fileSystems."/snap/snapd/20092" = {
    device = "/var/lib/snapd/snaps/snapd_20092.snap";
    fsType = "squashfs";
    options = ["loop"];
  };

  fileSystems."/snap/core20/1974" = {
    device = "/var/lib/snapd/snaps/core20_1974.snap";
    fsType = "squashfs";
    options = ["loop"];
  };

  fileSystems."/snap/lxd/22923" = {
    device = "/var/lib/snapd/snaps/lxd_22923.snap";
    fsType = "squashfs";
    options = ["loop"];
  };

  fileSystems."/snap/lxd/24322" = {
    device = "/var/lib/snapd/snaps/lxd_24322.snap";
    fsType = "squashfs";
    options = ["loop"];
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
