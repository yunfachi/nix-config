{
  module-functions,
  hm,
  pkgs,
  decryptSecret,
  ypkgs,
  lib,
  ...
}:
module-functions.module "services" "mopidy" (cfg: {
  yunfachi.programs.firefox.bookmarks = lib.mkOptionDefault [
    {
      name = "mopidy";
      url = "http://localhost:6680/iris";
    }
  ];

  hm.services.mopidy = {
    enable = true;
    extensionPackages = with pkgs;
      [
        mopidy-iris
        mopidy-mpd

        ypkgs.mopidy-alsamixer

        mopidy-youtube
        yt-dlp-light
      ]
      ++ lib.optional cfg.jellyfin.enable mopidy-jellyfin;

    settings = {
      http = {
        enabled = true;
        hostname = "127.0.0.1";
        port = 6680;
      };

      core = {
        max_tracklist_length = 10000;
        restore_state = true;
      };

      file = {
        media_dirs = cfg.media_dirs;
        follow_symlinks = true;
      };

      youtube = {
        enabled = true;
        allow_cache = true;
        youtube_dl_package = "yt_dlp";

        api_enabled = true;
        youtube_api_key = decryptSecret "services/mopidy/youtube/api_key";
        channel_id = decryptSecret "services/mopidy/youtube/channel_id";
      };

      mpd = {
        enabled = true;
        hostname = "::";
      };

      audio = {
        mixer = "alsamixer";
      };

      alsamixer = {
        volume_scale = "cubic";
      };

      jellyfin = lib.mkIf cfg.jellyfin.enable (builtins.removeAttrs cfg.jellyfin ["enable"]);
    };
  };
})
