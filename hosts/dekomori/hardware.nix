{
  delib,
  lib,
  modulesPath,
  ...
}:
delib.host {
  name = "dekomori";

  homeManagerSystem = "x86_64-linux";
  home.home.stateVersion = "24.05";

  nixos = {
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "24.05";

    imports = [(modulesPath + "/profiles/qemu-guest.nix")];

    boot = {
      initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_blk"];
      initrd.kernelModules = [];
      kernelModules = ["kvm-amd"];
      extraModulePackages = [];
    };

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/f222513b-ded1-49fa-b591-20ce86a2fe7f";
        fsType = "ext4";
      };
      "/boot" = {
        device = "systemd-1";
        fsType = "autofs";
      };
    };

    swapDevices = [];
    networking.useDHCP = lib.mkDefault true;
  };
}
