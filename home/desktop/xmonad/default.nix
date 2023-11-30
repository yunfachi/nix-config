{...}: {
  xsession = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;

      extraPackages = hp: [
        hp.dbus
        hp.monad-logger
      ];
      config = ./xmonad.hs;
    };
  };
}
