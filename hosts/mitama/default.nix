{
  delib,
  decryptHostSecretFile,
  ...
}:
delib.host {
  name = "mitama";

  rice = "hito";
  type = "desktop";

  displays = [
    {
      name = "eDP-1";
      primary = true;
      refreshRate = 60;
      width = 1920;
      height = 1080;
      x = 0;
      y = 0;
    }
  ];

  myconfig = {name, ...}: {
    services = {
      wireguard.privateKeyFile = decryptHostSecretFile name "services/wireguard/privateKey";
    };
  };
}
