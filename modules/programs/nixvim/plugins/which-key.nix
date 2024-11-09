{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.which-key";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.which-key = {
    enable = true;
  };
}
