{
  delib,
  decryptHostSecretFile,
  ...
}:
delib.host {
  name = "dekomori";

  rice = "hito";
  type = "server";

  myconfig = {name, ...}: {
    services = {
      wireguard = {
        enable = true;
        privateKeyFile = decryptHostSecretFile name "services/wireguard/privateKey";
      };
    };
  };
}
