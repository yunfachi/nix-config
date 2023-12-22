{
  config,
  lib,
  modulesPath,
  system,
  ...
}: {
  imports = [];

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  swapDevices = [];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "${system}";
}
