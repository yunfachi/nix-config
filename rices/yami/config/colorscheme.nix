{delib, ...}:
delib.rice {
  name = "yami";

  myconfig = {myconfig, ...}: {
    colorscheme = myconfig.colorschemes.kanagawa-dragon;
  };
}
