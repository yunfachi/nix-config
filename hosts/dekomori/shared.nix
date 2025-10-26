{
  delib,
  decryptSecret,
  lib,
  ...
}:
delib.host {
  name = "dekomori";

  shared.myconfig =
    { name, ... }:
    {
      programs.rbw.baseUrl = decryptSecret "programs/rbw/base_url";

      services = {
        sshd = {
          authorizedKeys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHj/D/Zgq7biN7dhAfatnQdVR316NORmyYzvSQwAQIhz yunfachi@dekomori"
          ];
        };

        wireguard = {
          server = {
            ip = "127.0.0.1"; # xray dokodemo door
            port = lib.toInt (decryptSecret "services/wireguard/servers/${name}/port");
            openFirewall = false;

            hostname = name;
            interface = "ens3";
            tunnel = "10.0.1.1";
            publicKey = decryptSecret "services/wireguard/servers/${name}/publicKey";
          };

          clients = {
            "a52" = {
              ip = "10.0.1.201";
              publicKey = decryptSecret "services/wireguard/clients/a52/publicKey";
            };
            "p11" = {
              ip = "10.0.1.202";
              publicKey = decryptSecret "services/wireguard/clients/p11/publicKey";
            };
            "m21" = {
              ip = "10.0.1.203";
              publicKey = decryptSecret "services/wireguard/clients/m21/publicKey";
            };
            "w3e" = {
              ip = "10.0.1.204";
              publicKey = decryptSecret "services/wireguard/clients/w3e/publicKey";
            };
          };
        };

        xray.server =
          let
            clients = builtins.fromJSON (decryptSecret "services/xray/clients");
            mapClients = f: map f (builtins.attrValues clients);
          in
          {
            ip = decryptSecret "hosts/dekomori/ip";
            port = 443;

            publicKey = decryptSecret "services/xray/server/publicKey";

            clientIds = mapClients (client: client.id);
            shortIds = mapClients (client: client.shortId);
          };
      };
    };
}
