{module-functions, ...}:
module-functions.module "services" "uni-sync" (cfg: {
  nypkgs.hardware.uni-sync = {inherit (cfg) enable devices;};
})
