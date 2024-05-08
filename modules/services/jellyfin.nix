{module-functions, ...}:
module-functions.module "services" "jellyfin" {
  services.jellyfin = {
    enable = true;

    openFirewall = true;
  };
}
