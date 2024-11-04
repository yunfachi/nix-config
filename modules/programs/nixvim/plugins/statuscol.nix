{delib, ...}:
delib.module {
  name = "programs.nixvim.plugins.statuscol";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.statuscol = {
    enable = true;

    settings = {
      relculright = true;

      segments = [
        {
          text = [
            {__raw = "require('statuscol.builtin').foldfunc";}
            " "
          ];
          click = "v:lua.ScFa";
        }
        {
          text = ["%s"];
          click = "v:lua.ScSa";
        }
        {
          text = [
            {__raw = "require('statuscol.builtin').lnumfunc";}
            " "
          ];
          click = "v:lua.ScLa";
        }
      ];
    };
  };
}
