{delib, ...}:
delib.rice {
  name = "hito";

  myconfig = {myconfig, ...}: {
    colorscheme = myconfig.colorschemes.coffee;
  };
}
