{
  module-functions,
  username,
  pkgs,
  ...
}:
module-functions.module "services" "jellyfin" (cfg: {
  services.jellyfin = {
    enable = true;
    openFirewall = cfg.openFirewall;

    user = username;
  };
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
})
