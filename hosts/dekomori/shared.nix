{hostName}: {
  username,
  user,
  decryptSecret,
  lib,
  ...
}: {
  user.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJJ7BWZyU1dpLM47Y6JI+NKd6sOvXm6JCyqHhrp4NsmD yunfachi@dekomori"];

  sops.secrets = {
    "hosts/dekomori/ip".owner = username;
    "wireguard/servers/dekomori/privateKey".owner = username;
  };

  yunfachi = {
    services.wireguard = {
      server = {
        ip = decryptSecret "hosts/dekomori/ip";
        port = lib.toInt (decryptSecret "wireguard/servers/dekomori/port");
        interface = "ens3";
        tunnel = "10.0.0.1";
        publicKey = decryptSecret "wireguard/servers/dekomori/publicKey";
      };

      clients = {
        "a52" = {
          ip = "10.0.0.201";
          publicKey = decryptSecret "wireguard/clients/a52/publicKey";
        };
        "p11" = {
          ip = "10.0.0.202";
          publicKey = decryptSecret "wireguard/clients/p11/publicKey";
        };
      };
    };
  };
}
