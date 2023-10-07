{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    xdg-utils
    xdg-user-dirs
  ];

  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    mimeApps = {
      enable = true;
      defaultApplications = let
        browser = ["firefox.desktop"];
      in {
        "application/json" = browser;
        "application/pdf" = browser;

        "text/html" = browser;
        "text/xml" = browser;
        "application/xml" = browser;
        "application/xhtml+xml" = browser;
        "application/xhtml_xml" = browser;
        "application/rdf+xml" = browser;
        "application/rss+xml" = browser;
        "application/x-extension-htm" = browser;
        "application/x-extension-html" = browser;
        "application/x-extension-shtml" = browser;
        "application/x-extension-xht" = browser;
        "application/x-extension-xhtml" = browser;

        "x-scheme-handler/about" = browser;
        "x-scheme-handler/ftp" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/unknown" = browser;

        "x-scheme-handler/discord" = ["discord.desktop"];
        "x-scheme-handler/tg" = ["telegramdesktop.desktop"];

        "audio/*" = browser;
        "video/*" = browser;
        "image/*" = browser;
        "image/gif" = browser;
        "image/jpeg" = browser;
        "image/png" = browser;
        "image/webp" = browser;
      };
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_DESKTOP_DIR = "${config.home.homeDirectory}/misc/desktop";
        XDG_DOCUMENTS_DIR = "${config.home.homeDirectory}/misc/documents";
        XDG_DOWNLOAD_DIR = "${config.home.homeDirectory}/misc/download";
        XDG_MUSIC_DIR = "${config.home.homeDirectory}/misc/music";
        XDG_PUBLICSHARE_DIR = "${config.home.homeDirectory}/misc/publicshare";
        XDG_TEMPLATES_DIR = "${config.home.homeDirectory}/misc/templates";

        XDG_PICTURES_DIR = "${config.home.homeDirectory}/media/pictures";
        XDG_VIDEOS_DIR = "${config.home.homeDirectory}/media/videos";
        XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/media/screenshots";
      };
    };
  };
}
