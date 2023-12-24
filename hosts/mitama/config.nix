{...}: {
  yunfachi = {
    type = "desktop";
    canary.enable = false;
    monitors = [
      {
        name = "DP-3";
        width = 1920;
        height = 1080;
        x = 0;
        y = 0;
        refreshRate = 144;
        scale = 1.0;
        primary = true;
      }
    ];
    wireguard.enable = false;
  };
}
