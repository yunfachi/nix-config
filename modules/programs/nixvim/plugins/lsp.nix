{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.lsp";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    plugins.lsp = {
      enable = true;

      servers = {
        nil_ls.enable = true;

        dartls.enable = true;

        rust-analyzer = {
          enable = true;

          installCargo = true;
          installRustc = true;
        };
      };
    };

    diagnostics.update_in_insert = true;
  };
}
