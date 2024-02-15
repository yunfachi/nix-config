{
  module-functions,
  hm,
  pkgs,
  config,
  host,
  ...
}:
module-functions.module null "xdg" {
  hm.xdg = {
    enable = true;

    portal = {
      enable = true;
      extraPortals = with pkgs;
        (lib.optional host.isWayland
          xdg-desktop-portal-wlr)
        ++ (lib.optional config.yunfachi.services.hyprland.enable
          xdg-desktop-portal-hyprland);
    };

    userDirs = rec {
      enable = true;
      createDirectories = true;

      download = "${config.hm.home.homeDirectory}/download";
      pictures = "${config.hm.home.homeDirectory}/media";
      documents = "${config.hm.home.homeDirectory}/files";
      desktop = download;
      videos = pictures;
      music = documents;
      publicShare = documents;
      templates = documents;
    };
  };
}
