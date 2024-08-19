{
  delib,
  decryptSecret,
  lib,
  ...
}:
delib.host {
  name = "dekomori";

  shared.myconfig = {name, ...}: {
    services = {
      sshd = {
        authorizedKeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJJ7BWZyU1dpLM47Y6JI+NKd6sOvXm6JCyqHhrp4NsmD yunfachi@dekomori"];
      };

      wireguard = {
        server = {
          ip = decryptSecret "hosts/dekomori/ip";
          port = lib.toInt (decryptSecret "services/wireguard/servers/${name}/port");
          hostname = name;
          interface = "ens3";
          tunnel = "10.0.0.1";
          publicKey = decryptSecret "services/wireguard/servers/${name}/publicKey";
        };

        clients = {
          "a52" = {
            ip = "10.0.0.201";
            publicKey = decryptSecret "services/wireguard/clients/a52/publicKey";
          };
          "p11" = {
            ip = "10.0.0.202";
            publicKey = decryptSecret "services/wireguard/clients/p11/publicKey";
          };
          "m21" = {
            ip = "10.0.0.203";
            publicKey = decryptSecret "services/wireguard/clients/m21/publicKey";
          };
        };
      };
    };
  };
}
