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

    userDirs = let
      download = "${config.hm.home.homeDirectory}/download";
      media = category: "${config.hm.home.homeDirectory}/media/${category}";
      files = category: "${config.hm.home.homeDirectory}/files/${category}";
    in {
      enable = true;
      createDirectories = true;

      download = download;
      pictures = media "pictures";
      documents = files "documents";
      desktop = files "desktop";
      videos = media "videos";
      music = media "music";
      publicShare = files "publicshare";
      templates = files "templates";
    };
  };
}
