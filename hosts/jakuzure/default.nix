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
    services = {
      wireguard.privateKeyFile = decryptHostSecretFile name "services/wireguard/privateKey";
    };
  };
}
