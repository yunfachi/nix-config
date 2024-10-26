{delib, ...}:
delib.module {
  name = "program.nixvim.plugin.noice";

  option = delib.ingleEnableOptiontrue;

  home.ifEnabled.program.nixvim.plugin.noice = {
    enable = true;
  };
}
