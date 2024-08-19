{
  delib,
  spicetifyPkgs,
  pkgs,
  ...
}:
delib.module {
  name = "programs.spicetify";

  home.ifEnabled.programs.spicetify = {
    enabledExtensions = with spicetifyPkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
      skipStats
    ];

    enabledCustomApps = with spicetifyPkgs.apps; [
      marketplace
      ncsVisualizer
      {
        src = pkgs.fetchzip {
          # https://github.com/harbassan/spicetify-apps/releases
          url = "https://github.com/harbassan/spicetify-apps/releases/download/stats-v1.1.1/spicetify-stats.release.zip";
          hash = "sha256-b2QZnKjUnsJ40QM1CZ2Rk7WXPsHmCvBrokKaZN8X3yQ=";
        };
        name = "stats";
      }
      {
        src = pkgs.fetchzip {
          # https://github.com/Pithaya/spicetify-apps-dist/tree/dist/eternal-jukebox
          url = "https://github.com/Pithaya/spicetify-apps-dist/archive/d643d2c4c3824a8ce22142c68431bec5af6d1fcb.zip";
          hash = "sha256-My1TuuFeih3QgaU8Nfv8ocIzE55ypM/QmfCt4RPy/5g=";
        };
        name = "eternal-jukebox";
      }
    ];
  };
}
