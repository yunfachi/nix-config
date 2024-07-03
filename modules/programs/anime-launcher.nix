{
  module-functions,
  inputs,
  config,
  lib,
  ...
}:
module-functions.moduleIfElseFinally "programs" "anime-launcher"
{
  nix.settings = inputs.anime-launcher.nixConfig;
  programs.anime-game-launcher.enable = true;

  yunfachi.programs.firefox.bookmarks = lib.mkOptionDefault [
    {
      name = "genshin";
      bookmarks = [
        {
          name = "тейват";
          url = let
            shown_types = "5,2,3,154,319,338,6,194,403,508,141,325,326,327,429,184,356,458,465,466,470,471,472,554,17,44,269,45,46,8,9,212,411,509,18,70,64,71,77,520,499,547,67,72,73,155,65,74,68,76,205,258,230,259,83,66,216,148,69,75,231,226,225,270,396,399,397,407,369,79,353,354,398,444,445,446,447,448,460,461,464,459,473,474,475,476,480,543,544,550,551,542,479,478,477,481,482,562,576,578,581,561,560,559,552,366,424,395,321,332,330,361,574,575,584,587,573,189,188,187,453,159,156,416,409,147,268,267,415,85,171,87,317,264,112,111,128,439,329,52";
          in "https://act.hoyolab.com/ys/app/interactive-map/index.html?lang=ru-ru#/map/2?shown_types=${shown_types}&center=-1217.99,-4411.99&zoom=-2.00";
        }
        {
          name = "разлом";
          url = let
            shown_types = "453,85,358,359,52,79,231,72,18,70,77,64,46,45,44,17,357,3";
          in "https://act.hoyolab.com/ys/app/interactive-map/index.html?lang=ru-ru#/map/9?shown_types=${shown_types}&center=-66.00,-233.00&zoom=0.00";
        }
        {
          name = "молитвы";
          url = "https://paimon.moe/wish";
        }
        {
          name = "отметки";
          url = "https://act.hoyolab.com/ys/event/signin-sea-v3/index.html?act_id=e202102251931481&lang=ru-ru";
        }
        {
          name = "вики";
          url = "https://wiki.hoyolab.com/pc/genshin/home";
        }
      ];
    }
  ];
}
{
  yunfachi.programs.firefox.bookmarks = lib.mkOptionDefault [
    {
      name = "genshin daily";
      url = "https://act.hoyolab.com/ys/event/signin-sea-v3/index.html?act_id=e202102251931481&lang=ru-ru";
    }
  ];
}
{
  imports = [inputs.anime-launcher.nixosModules.default];
}
