{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.cmp";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.cmp = {
    enable = true;

    autoEnableSources = true;
    settings = {
      sources = [
        {name = "nvim_lsp";}
        {name = "path";}
        {name = "buffer";}
      ];

      mapping = {
        "<S-CR>" = "cmp.mapping.confirm({ select = true })";
        "<C-e>" = "cmp.mapping.abort()";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
      };
    };
  };
}
