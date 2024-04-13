{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "services" "mopidy" (cfg: {
  hm.services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-iris
      mopidy-mpd

      mopidy-youtube
      yt-dlp-light
    ];

    settings = {
      http = {
        enabled = true;
        hostname = "127.0.0.1";
        port = 6680;
      };

      file = {
        media_dirs = cfg.media_dirs;
        follow_symlinks = true;
      };

      youtube = {
        enabled = true;
        autoplay_enabled = true;
        allow_cache = true;
        youtube_dl_package = "yt_dlp";
      };

      mpd = {
        enabled = true;
        hostname = "::";
      };
    };
  };
})
