{delib, ...}:
delib.rice {
  name = "shikakukutekurai";

  myconfig = {myconfig, ...}: {
    colorscheme = myconfig.colorschemes.biscuit-sol-dark;
  };
}
