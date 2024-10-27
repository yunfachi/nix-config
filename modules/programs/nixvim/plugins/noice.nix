{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.noice";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.noice = {
    enable = true;
  };
}
