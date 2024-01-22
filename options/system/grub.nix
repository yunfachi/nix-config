{option-functions, ...}:
with option-functions;
  option "system" "grub" {
    enable = enableOption "grub" true;
    mode = enumOption "mode" (
      if builtins.pathExists /sys/firmware/efi/efivars
      then "uefi"
      else "legacy"
    ) ["uefi" "legacy"];
  }
