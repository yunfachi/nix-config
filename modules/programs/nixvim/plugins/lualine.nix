{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.lualine";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.lualine = {
    enable = true;
  };
}
