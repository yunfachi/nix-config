{
  delib,
  decryptHostSecretFile,
  decryptSecret,
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
    bluetooth.enable = true;

    programs = {
      git.signingKey = "0x9D16EF5F68A5CEDF";

      xp-pen-deco-pro.enable = true;
    };

    services = {
      wireguard.privateKeyFile = decryptHostSecretFile name "services/wireguard/privateKey";
      xray.client = {
        id = decryptSecret "services/xray/clients/${name}/id";
        shortId = decryptSecret "services/xray/clients/${name}/shortId";
      };
    };
  };
}
