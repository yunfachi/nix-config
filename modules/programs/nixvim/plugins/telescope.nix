{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.telescope";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.telescope = {
    enable = true;
  };
}
