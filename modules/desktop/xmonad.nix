{...}: {
  services.xserver = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };

    displayManager.defaultSession = "none+xmonad";
    xkbOptions = "grp:win_space_toggle";
    layout = "us,ru";
  };
}
