{module-functions, ...}:
module-functions.module "system" "grub" (cfg: {
  boot.loader.grub = {
    enable = true;
    efiSupport = cfg.mode == "uefi";
    devices = ["nodev"];
  };
})
