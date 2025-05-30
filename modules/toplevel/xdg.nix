{
  delib,
  host,
  homeconfig,
  ...
}:
delib.module {
  name = "xdg";

  options.xdg = with delib; {
    enable = boolOption host.isDesktop; # FIXME
    mime = {
      recommended = attrsOfOption (listOf str) {};
      associations = attrsOfOption (listOf str) {};
      removed = attrsOfOption (listOf str) {};
    };
  };

  myconfig.ifEnabled.persist.user.directories = ["media" "files"];

  home.ifEnabled = {cfg, ...}: {
    xdg = {
      enable = true;

      userDirs = let
        download = "${homeconfig.home.homeDirectory}/download";
        media = category: "${homeconfig.home.homeDirectory}/media/${category}";
        files = category: "${homeconfig.home.homeDirectory}/files/${category}";
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

      mimeApps = {
        enable = true;

        defaultApplications = cfg.mime.recommended;
        associations.added = cfg.mime.associations;
        associations.removed = cfg.mime.removed;
      };
    };
  };

  nixos.ifEnabled.environment.variables.XDG_CACHE_DIR = "${homeconfig.home.homeDirectory}/.cache";
}
