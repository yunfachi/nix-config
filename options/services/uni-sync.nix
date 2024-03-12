{
  option-functions,
  options,
  lib,
  ...
}:
with option-functions;
  option "services" "uni-sync" {
    enable = enableOption "uni-sync" false;
    devices = options.nypkgs.hardware.uni-sync.devices;
  }
