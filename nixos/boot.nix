{lib, ...}: {
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = lib.mkForce true;
      efiSupport = true;
      device = "nodev";
    };
  };
}
