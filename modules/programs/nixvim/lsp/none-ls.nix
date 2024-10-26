{delib, ...}:
delib.module {
  name = "programs.nixvim.lsp.none-ls";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    updateInInsert = true;
    diagnosticConfig = {
      update_in_insert = true;
    };

    sources = {
      diagnostics = {
        statix.enable = true;
      };
      formatting = {
        alejandra.enable = true;
      };
    };
  };
}
