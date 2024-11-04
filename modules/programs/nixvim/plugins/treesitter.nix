{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.treesitter";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.treesitter = {
    enable = true;

    settings = {
      ensureInstalled = "all";

      highlight.enable = true;
      indent.enable = true;
    };
  };
}
