{
  module-functions,
  hm,
  pkgs,
  inputs,
  config,
  ...
}:
module-functions.moduleIfEnabledFinally "programs" "spotify" (let
  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.system};
in {
  hm.programs.spicetify = {
    enable = true;
    alwaysEnableDevTools = true;

    theme = spicePkgs.themes.text;
    colorScheme = "custom";
    customColorScheme = with config.yunfachi.rice.colorscheme; {
      accent = base0B.value;
      accent-active = base0B.value;
      accent-inactive = base00.value;
      banner = base0B.value;
      border-active = base0B.value;
      border-inactive = base03.value;
      header = base04.value;
      highlight = base04.value;
      main = base00.value;
      notification = base0D.value;
      notification-error = base08.value;
      subtext = base06.value;
      text = base05.value;
    };

    enabledSnippets = with spicePkgs.snippets; [
      hideFriendActivityButton
      hideFullScreenButton
      roundedImages
      ".Root__top-container:has([class*='yourLibraryX']) { padding-top: 16px; }"
      "button.encore-text-body-medium-bold.encore-over-media-set > figure > div > img { border-radius: 50% !important; }"
      ".player-controls__buttons,.main-nowPlayingBar-extraControls { opacity: .4; }"
    ];

    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
      skipStats
    ];

    enabledCustomApps = with spicePkgs.apps; [
      marketplace
      ncsVisualizer
      {
        src = pkgs.fetchzip {
          # https://github.com/harbassan/spicetify-apps/releases
          url = "https://github.com/harbassan/spicetify-apps/releases/download/stats-v1.1.0/spicetify-stats.release.zip";
          hash = "sha256-m0lsxNV4rC3FAmPQxmCZGzdNBsEC/q3LXR90VhGjrJM=";
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
})
{
  hm.imports = [inputs.spicetify.homeManagerModules.default];
}
