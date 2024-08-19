{
  delib,
  config,
  lib,
  modulesPath,
  ...
}:
delib.host {
  name = "jakuzure";

  homeManagerSystem = "x86_64-linux";
  home.home.stateVersion = "24.05";

  nixos = {
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "24.05";

    imports = [(modulesPath + "/installer/scan/not-detected.nix")];

    boot = {
      initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      initrd.kernelModules = [];
      kernelModules = ["kvm-amd"];
      extraModulePackages = [];
    };

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/fe7d20c8-68b5-4157-a479-5851867d2a91";
        fsType = "ext4";
      };
      "/boot" = {
        device = "/dev/disk/by-uuid/6EF6-D17B";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };
      "/media" = {
        device = "/dev/disk/by-uuid/49f1f992-311a-4dbd-b48e-46f132eccea2";
        fsType = "ext4";
      };
    };

    swapDevices = [{device = "/dev/disk/by-uuid/ce3c1f2b-a47e-4302-8794-7064418f0b76";}];

    networking.useDHCP = lib.mkDefault true;
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
