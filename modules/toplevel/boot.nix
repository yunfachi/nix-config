{
  delib,
  lib,
  host,
  pkgs,
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

      plymouth = {
        enable = boolOption host.isDesktop;
      };
    };
  };

  nixos.ifEnabled = {cfg, ...}: {
    boot = {
      loader = {
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
          consoleMode = "max";
        };

        timeout = 0; # 5;
      };
      consoleLogLevel = 0;
      initrd.verbose = false;
      plymouth = {
        enable = cfg.plymouth.enable;
        logo = "${pkgs.nixos-icons}/share/icons/hicolor/256x256/apps/nix-snowflake-white.png";
        theme = "breeze";
      };
      kernelParams = [
        "quiet"
        "splash"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
        "boot.shell_on_fail"
      ];
    };
  };
}
