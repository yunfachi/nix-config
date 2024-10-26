{delib, ...}:
delib.module {
  name = "programs.nixvim.lsp.nil-ls";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.lsp.servers.nil-ls = {
    enable = true;
  };
}
