{
  config,
  lib,
  modulesPath,
  system,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = [];
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/66b29ea1-e3d5-4e5f-b0e9-298b3ea7c10f";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/7F03-29CB";
      fsType = "vfat";
    };
    "/media" = {
      device = "/dev/disk/by-uuid/49f1f992-311a-4dbd-b48e-46f132eccea2";
      fsType = "ext4";
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/4fe823eb-9f5d-4f1d-b412-75c21c2ea0e6";}
  ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "${system}";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  system.stateVersion = "24.05";
}
