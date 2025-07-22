{delib, ...}:
delib.module {
  name = "programs.nixvim.lsp.qmlls";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.lsp.servers.qmlls = {
    enable = true;
  };
}
