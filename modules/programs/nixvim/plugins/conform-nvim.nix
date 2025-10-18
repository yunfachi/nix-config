{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.conform-nvim";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.conform-nvim = {
    enable = true;

    settings = {
      notify_on_error = true;

      format_on_save = {
        lsp_format = "fallback";
        timeout_ms = 500;
      };

      formatters_by_ft = {
        nix = ["nixfmt"];
      };
    };
  };
}
