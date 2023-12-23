{
  config,
  lib,
  ...
}: let
  cfg = config.yunfachi.grub;
in {
  config = {
    boot.loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = lib.mkForce cfg.enable;
        efiSupport = true;
        devices = ["nodev"];
      };
    };
  };
}
