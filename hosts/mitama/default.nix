{
  delib,
  decryptHostSecretFile,
  ...
}:
delib.host {
  name = "mitama";

  rice = "yami";
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
    programs = {
      # git.signingKey = "0x";
      xp-pen-deco-pro.enable = true;
    };

    services = {
      wireguard.privateKeyFile = decryptHostSecretFile name "services/wireguard/privateKey";
    };
  };
}
