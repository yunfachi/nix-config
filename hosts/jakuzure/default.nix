{
  delib,
  decryptHostSecretFile,
  ...
}:
delib.host {
  name = "jakuzure";

  rice = "yami";
  type = "desktop";

  displays = [
    {
      name = "DP-3";
      primary = true;
      refreshRate = 144;
      width = 1920;
      height = 1080;
      x = 0;
      y = 0;
    }
    {
      name = "HDMI-A-1";
      refreshRate = 60;
      width = 1920;
      height = 1080;
      x = 1920;
      y = 100;
    }
  ];

  myconfig = {name, ...}: {
    programs = {
      git.signingKey = "0x9D16EF5F68A5CEDF";

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

      xp-pen-deco-pro.enable = true;
    };

    services = {
      wireguard.privateKeyFile = decryptHostSecretFile name "services/wireguard/privateKey";
    };
  };
}
