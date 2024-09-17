{
  delib,
  decryptHostSecretFile,
  wireguardLocalAddress,
  ...
}:
delib.host {
  name = "dekomori";

  rice = "hito";
  type = "server";

  myconfig = {name, ...}: {
    infras = {
      changelog.enable = true;
      deshiro.enable = true;
    };

    services = {
      postgresql = {
        enable = true;

        openFirewall = true;
        listen_addresses = [wireguardLocalAddress];
      };

      wireguard = {
        enable = true;
        privateKeyFile = decryptHostSecretFile name "services/wireguard/privateKey";
      };
    };
  };
}
