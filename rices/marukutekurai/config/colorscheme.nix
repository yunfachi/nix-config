{delib, ...}:
delib.rice {
  name = "marukutekurai";

  myconfig = {myconfig, ...}: {
    colorscheme = myconfig.colorschemes.biscuit-sol-dark;
  };
}
