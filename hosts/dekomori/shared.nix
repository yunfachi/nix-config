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
    "hosts/dekomori/wireguard/privateKey".owner = username;
  };

  yunfachi = {
    services.wireguard = {
      server = {
        ip = decryptSecret "hosts/dekomori/ip";
        port = lib.toInt (decryptSecret "hosts/dekomori/wireguard/server/port");
        interface = "ens3";
        tunnel = "10.0.0.1";
        publicKey = decryptSecret "hosts/dekomori/wireguard/server/publicKey";
      };
    };
  };
}
