{config, ...}: {
  host.type = "desktop";

  yunfachi = {
    infras = {
      deshiro.enable = true;
    };
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

    services = {
      wireguard.privateKeyFile = config.sops.secrets."wireguard/clients/mitama/privateKey".path;

      uni-sync = {
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
  };
}
