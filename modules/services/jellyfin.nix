{
  module-functions,
  username,
  pkgs,
  lib,
  ...
}:
module-functions.module "services" "jellyfin" (cfg: {
  yunfachi.programs.firefox.bookmarks = lib.mkOptionDefault [
    {
      name = "jellyfin";
      url = "http://localhost:8096/";
    }
  ];

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
