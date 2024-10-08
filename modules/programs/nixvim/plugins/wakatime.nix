{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.wakatime";

  options = {myconfig, ...}: {
    programs.nixvim.plugins.wakatime.enable = delib.boolOption myconfig.wakatime.enable;
  };

  home.ifEnabled.programs.nixvim.plugins.wakatime.enable = true;
}
