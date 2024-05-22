{
  module-functions,
  inputs,
  config,
  ...
}:
module-functions.moduleIfEnabledFinally "programs" "anime-launcher"
{
  nix.settings = inputs.anime-launcher.nixConfig;
  programs.anime-game-launcher.enable = true;
}
{
  imports = [inputs.anime-launcher.nixosModules.default];
}
