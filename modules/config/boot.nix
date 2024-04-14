{
  module-functions,
  lib,
  ...
}:
module-functions.module null "boot" (cfg: {
  boot = {
    kernelParams = lib.mkIf cfg.silent [
      "quiet"
      "splash"
      "vga=current"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    consoleLogLevel = lib.mkIf cfg.silent 0;
  };
})
