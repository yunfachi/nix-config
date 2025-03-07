{
  delib,
  config,
  lib,
  modulesPath,
  ...
}:
delib.host {
  name = "mitama";

  homeManagerSystem = "x86_64-linux";
  home.home.stateVersion = "23.11";

  myconfig.boot.mode = "uefi";

  nixos = {
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "23.11";

    imports = [(modulesPath + "/installer/scan/not-detected.nix")];

    boot = {
      initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "sd_mod"];
      initrd.kernelModules = [];
      kernelModules = ["kvm-amd"];
      extraModulePackages = [];
    };

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/bc28e92b-d3a5-47ec-9c09-1237adfdd820";
        fsType = "ext4";
      };
      "/boot" = {
        device = "/dev/disk/by-uuid/F429-0FED";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };
    };

    swapDevices = [];
    networking.useDHCP = lib.mkDefault true;
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
