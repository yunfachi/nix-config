{
  delib,
  lib,
  modulesPath,
  ...
}:
delib.host {
  name = "dekomori";

  system = "x86_64-linux";

  home.home.stateVersion = "24.11";

  myconfig.boot.mode = "legacy";

  nixos = {
    system.stateVersion = "24.11";

    imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

    boot = {
      initrd.availableKernelModules = [
        "ata_piix"
        "uhci_hcd"
        "virtio_pci"
        "sr_mod"
        "virtio_blk"
      ];
      initrd.kernelModules = [ ];
      kernelModules = [ "kvm-amd" ];
      extraModulePackages = [ ];
    };

    fileSystems."/" = {
      device = "/dev/vda2";
      fsType = "ext4";
    };

    networking.useDHCP = lib.mkDefault true;
  };
}
