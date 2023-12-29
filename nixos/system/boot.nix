{
  config,
  lib,
  ...
}: let
  cfg = config.yunfachi.boot;
in {
  config = {
    boot.loader = {
      efi = {
        canTouchEfiVariables = cfg.mode == "uefi";
      };
      grub = {
        enable = lib.mkForce true;
        efiSupport = lib.mkForce (cfg.mode == "uefi");
        devices = ["nodev"];
      };
    };
  };
}
