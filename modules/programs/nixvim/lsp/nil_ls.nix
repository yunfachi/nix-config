{ delib, ... }:
delib.module {
  name = "programs.nixvim.lsp.nil_ls";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.lsp.servers.nil_ls = {
    enable = true;
  };
}
