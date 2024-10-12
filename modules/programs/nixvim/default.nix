{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "programs.nixvim";

  options.programs.nixvim = with delib; {
    enable = boolOption true;

    defaultEditor = boolOption true;
  };

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
      };
    };
  };
}
