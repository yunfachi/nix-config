{
  delib,
  inputs,
  homeconfig,
  host,
  ...
}:
delib.module {
  name = "programs.nixvim";

  options.programs.nixvim = with delib; {
    enable = boolOption host.cliFeatured;

    defaultEditor = boolOption true;
  };

  myconfig.always.args.shared.nixvimLib = homeconfig.lib.nixvim;

  home.always.imports = [inputs.nixvim.homeManagerModules.nixvim];

  home.ifEnabled = {cfg, ...}: {
    programs.nixvim = {
      enable = true;
      inherit (cfg) defaultEditor;

      opts = {
        number = true;
        relativenumber = true;

        list = true;

        expandtab = true;
        tabstop = 2;
        shiftwidth = 2;
        softtabstop = 2;
        listchars.tab = "-»";

        foldcolumn = "1";
        foldlevel = 99;
        foldlevelstart = 99;
        foldenable = true;
        fillchars = {
          eob = " ";
          fold = " ";
          foldopen = "";
          foldsep = " ";
          foldclose = "";
        };

        clipboard = "unnamedplus";
      };

      diagnostics = {
        update_in_insert = true;
      };
    };
  };
}
