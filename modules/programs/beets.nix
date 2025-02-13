{
  delib,
  lib,
  ...
}:
delib.module {
  name = "programs.beets";

  options = {myconfig, ...}: {
    programs.beets = with delib; {
      enable = boolOption false;

      directory = noDefault (strOption null);
      database = noDefault (strOption null);

      subsonicUpdate = {
        enable = boolOption false;
        # TODO: https://github.com/yunfachi/denix/issues/18
        url =
          (
            if myconfig.services.navidrome.enable
            then (x: x)
            else noDefault
          ) (strOption (
            if myconfig.services.navidrome.enable
            then "http://${myconfig.services.navidrome.address}:${toString myconfig.services.navidrome.port}"
            else null
          ));
        user = strOption "admin";
        pass = strOption "admin";
        auth = enumOption ["token" "password"] "password";
      };

      extraSettings = attrsOption {};
    };
  };

  home.ifEnabled = {cfg, ...}: {
    programs.beets = {
      enable = true;
      settings =
        {
          inherit (cfg) directory;
          library = cfg.database;

          /*
          MAIN
          */
          import = {
            from_scratch = true;
          };
          paths = {
            default = "$albumartist - $album%aunique{}/$track $title";
            # TODO: set proper values after the first singletons and compilations appear in my library
            singleton = "Non-Album/$artist/$title";
            comp = "Compilations/$album%aunique{}/$track $title";
          };

          /*
          PLUGINS
          */
          subsonic = lib.mkIf cfg.subsonicUpdate.enable {
            inherit (cfg.subsonicUpdate) url user pass auth;
          };

          # TODO: configure properly
          spotify = {
            show_failures = true;
          };

          lastgenre = {
            count = 3; # TODO: count = 1 and good custom whitelist
          };

          lyrics = {
            # synced works incorrectly, so the order is important (lrclib is the only one that offers synced lyrics)
            sources = ["lrclib" "genius" "tekstowo" "google"];
            synced = true;
            force = true;
          };

          replaygain = {
            parallel_on_import = true;
            backend = "ffmpeg";
            overwrite = true;
            targetlevel = 89;
            r128_targetlevel = 84;
            r128 = ["flac" "mp3"];
          };

          plugins =
            [
              "spotify"
              "mbsync"

              "lastgenre"
              "lyrics"

              "fetchart"
              "thumbnails"
              "embedart"

              "replaygain"

              "duplicates"
              "missing"
            ]
            ++ lib.optional cfg.subsonicUpdate.enable "subsonicupdate";
        }
        // cfg.extraSettings;
    };
  };
}
