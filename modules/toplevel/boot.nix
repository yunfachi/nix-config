{
  delib,
  lib,
  ...
}:
delib.module {
  name = "boot";

  options = {cfg, ...}: {
    boot = with delib; {
      enable = boolOption true;

      loader = enumOption ["grub" "systemd-boot"] (
        if cfg.mode == "uefi"
        then "systemd-boot"
        else "grub"
      );
      mode = enumOption ["uefi" "legacy"] (
        if builtins.pathExists /sys/firmware/efi/efivars
        then "uefi"
        else "legacy"
      );
    };
  };

  nixos.ifEnabled = {cfg, ...}: {
    boot.loader = {
      efi = {
        canTouchEfiVariables = true;
      };

      grub = lib.mkIf (cfg.loader == "grub") {
        enable = true;
        efiSupport = cfg.mode == "uefi";
        devices = ["nodev"];
        configurationLimit = 10;
      };

      systemd-boot = lib.mkIf (cfg.loader == "systemd-boot") {
        enable = true;
        configurationLimit = 10;
      };

      timeout = 5;
    };
  };
}
