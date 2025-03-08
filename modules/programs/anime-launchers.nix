{
  delib,
  inputs,
  lib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.anime-launchers";

  options.programs.anime-launchers = with delib; {
    enable = boolOption (host.guiFeatured && host.gamingFeatured);
    enableAnimeGameLauncher = boolOption true;
    enableSleepyLauncher = boolOption true;
    enableHonkersRailwayLauncher = boolOption true;
  };

  nixos.always.imports = [inputs.anime-launcher.nixosModules.default];
  nixos.ifEnabled = {
    nix.settings = inputs.anime-launcher.nixConfig;

    networking.mihoyo-telemetry.block = true;
  };

  home.ifEnabled = {cfg, ...}: {
    nix.settings = inputs.anime-launcher.nixConfig;

    home.packages = with inputs.anime-launcher.packages.${pkgs.system};
      (lib.optional cfg.enableAnimeGameLauncher anime-game-launcher)
      ++ (lib.optional cfg.enableSleepyLauncher sleepy-launcher)
      ++ (lib.optional cfg.enableHonkersRailwayLauncher honkers-railway-launcher);
  };

  myconfig.ifEnabled = {cfg, ...}: {
    persist.user.directories =
      lib.optional cfg.enableAnimeGameLauncher ".local/share/anime-game-launcher"
      ++ lib.optional cfg.enableSleepyLauncher ".local/share/sleepy-launcher"
      ++ lib.optional cfg.enableHonkersRailwayLauncher ".local/share/honkers-railway-launcher";

    programs.schizofox.bookmarks =
      lib.optionals cfg.enableAnimeGameLauncher [
        {
          Title = "тейват";
          URL = let
            shown_types = "17,269,0,44,45,46,626,356,70,64,71,77,66,65,72,547,597,598,599,600,85,5,6,194,403,508,141,325,326,327,429,184,458,471,472,465,466,554,470,8,9,212,411,509,18,520,499,67,73,155,74,68,76,205,258,230,259,83,216,148,69,75,231,226,225,270,396,369,407,397,399,79,353,354,398,447,464,461,474,475,446,445,444,448,460,473,459,476,480,543,552,562,577,576,578,581,561,551,542,479,478,477,481,482,550,544,559,560,395,424,321,332,330,329,112,264,317,147,156,639,52,663,647";
          in "https://act.hoyolab.com/ys/app/interactive-map/index.html?lang=ru-ru#/map/2?shown_types=${shown_types}&center=4357.00,-9257.00&zoom=-1.00";
          Placement = "toolbar";
          Folder = "Genshin";
        }
        {
          Title = "разлом";
          URL = let
            shown_types = "17,44,357,45,46,18,72,231,70,64,79,77,359,85,358";
          in "https://act.hoyolab.com/ys/app/interactive-map/index.html?lang=ru-ru#/map/9?shown_types=${shown_types}&center=-66.00,-233.00&zoom=0.00";
          Placement = "toolbar";
          Folder = "Genshin";
        }
        {
          Title = "молитвы";
          URL = "https://paimon.moe/wish";
          Placement = "toolbar";
          Folder = "Genshin";
        }
        {
          Title = "отметки";
          URL = "https://act.hoyolab.com/ys/event/signin-sea-v3/index.html?act_id=e202102251931481&lang=ru-ru";
          Placement = "toolbar";
          Folder = "Genshin";
        }
      ]
      ++ lib.optionals cfg.enableSleepyLauncher [
        {
          Title = "отметки";
          URL = "https://act.hoyolab.com/bbs/event/signin/zzz/e202406031448091.html?act_id=e202406031448091&lang=ru-ru";
          Placement = "toolbar";
          Folder = "Zenless";
        }
      ]
      ++ lib.optionals cfg.enableHonkersRailwayLauncher [
        {
          Title = "отметки";
          URL = "https://act.hoyolab.com/bbs/event/signin/hkrpg/index.html?act_id=e202303301540311&lang=ru-ru";
          Placement = "toolbar";
          Folder = "Honkai";
        }
      ];
  };
}
