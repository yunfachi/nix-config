{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.cmp";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.cmp = {
    enable = true;

    autoEnableSources = true;
    settings.sources = [
      {name = "nvim_lsp";}
      {name = "path";}
      {name = "buffer";}
    ];
  };
}
