{delib, ...}:
delib.module {
  name = "programs.nixvim.lsp.ts_ls";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.lsp.servers.ts_ls = {
    enable = true;
  };
}
