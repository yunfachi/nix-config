{module-functions, ...}:
module-functions.module "services" "openrgb" {
  services.hardware.openrgb = {
    enable = true;
  };
}
