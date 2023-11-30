{...}: {
  services.xserver = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;

      extraPackages = hp: [
        hp.dbus
        hp.monad-logger
      ];
    };

    displayManager.defaultSession = "none+xmonad";
    xkbOptions = "grp:win_space_toggle";
    layout = "us,ru";
  };
}
