{user, ...}: {
  host.type = "desktop";

  user.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILG1KltBx01hsQ7/DhRkLGFCADAX7KIumiTkbnE71pi2 yunfachi@mitama"];

  yunfachi = {
    hardware.displays = [
      {
        id = "DP-3";
        primary = true;
        refreshRate = 144;
      }
      {
        id = "HDMI-A-1";
        primary = false;
        refreshRate = 60;
        x = 1920;
        y = 100;
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
              _: {
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
