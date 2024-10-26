{delib, ...}:
delib.module {
  name = "programs.nixvim.lsp.dartls";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.lsp.servers.dartls = {
    enable = true;
  };
}
