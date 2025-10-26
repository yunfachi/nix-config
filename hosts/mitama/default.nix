{
  delib,
  decryptHostSecretFile,
  decryptSecret,
  ...
}:
delib.host {
  name = "mitama";

  rice = "marukutekurai";
  type = "desktop";
  features = [
    "powersave"
    "wireless"
  ];

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

  myconfig =
    { name, ... }:
    {
      programs = {
        git.signingKey = "0xA0CD74D32A0CB3F1";
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
