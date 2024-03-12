{...}: {
  host.type = "desktop";
  yunfachi = {
    hardware.displays = [
      {
        id = "DP-3";
        primary = true;
        refreshRate = 144;
      }
    ];
    services.uni-sync = {
      enable = true;
      devices = [
        {
          device_id = "VID:3314/PID:41219/SN:6243168001";
          sync_rgb = true;
          channels =
            builtins.genList (
              x: {
                mode = "Manual";
                speed = 70;
              }
            )
            4;
        }
      ];
    };
  };
}
