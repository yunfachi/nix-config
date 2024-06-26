{
  module-functions,
  inputs,
  config,
  lib,
  ...
}:
module-functions.moduleIfEnabledFinally "programs" "anime-launcher"
{
  nix.settings = inputs.anime-launcher.nixConfig;
  programs.anime-game-launcher.enable = true;

  yunfachi.programs.firefox.bookmarks = lib.mkOptionDefault [
    {
      name = "genshin map";
      url = "https://act.hoyolab.com/ys/app/interactive-map/index.html?lang=ru-ru#/map/2?shown_types=2,3,154,319,338,17,44,45,46,269,69,508,5,6,194,403,67,71,554,18,471,472,458,327,429,325,326,356,184,466,470,70,64,499,520,77,547,72,73,74,65,155,76,205,258,230,68,231,66,83,259,148,216,75,226,225,270,396,369,398,354,407,397,399,353,79,444,448,459,473,460,445,474,475,464,461,446,447,482,480,481,476,477,478,479,561,551,550,560,559,544,543,552,562,576,578,581,129,359,366,332,321,424,395,330,114,329,223,128,111,224,112,264,127,361,439,130,317,87,253,208,171,85,267,268,147,404,416,415,409,573,574,465,542,189&center=-1217.99,-4411.99&zoom=-2.00";
    }
  ];
}
{
  imports = [inputs.anime-launcher.nixosModules.default];

  yunfachi.programs.firefox.bookmarks = lib.mkOptionDefault [
    {
      name = "genshin daily";
      url = "https://act.hoyolab.com/ys/event/signin-sea-v3/index.html?act_id=e202102251931481&lang=en-us";
    }
  ];

}
