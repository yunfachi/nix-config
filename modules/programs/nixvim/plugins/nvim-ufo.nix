{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.nvim-ufo";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.nvim-ufo = {
    enable = true;
  };
}
