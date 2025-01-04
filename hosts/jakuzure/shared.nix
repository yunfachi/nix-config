{
  delib,
  decryptSecret,
  ...
}:
delib.host {
  name = "jakuzure";

  shared.myconfig = {name, ...}: {
    services = {
      sshd = {
        authorizedKeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC6lmOpmk0XqC7G5n6xBMVol8Div9PNpRrcQ211uwFh0 yunfachi@mitama"];
      };

      wireguard.clients.${name} = {
        ip = "10.0.1.101";
        publicKey = decryptSecret "services/wireguard/clients/${name}/publicKey";
      };
    };
  };
}
