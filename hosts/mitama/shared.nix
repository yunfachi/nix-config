{hostName}: {
  username,
  user,
  decryptSecret,
  ...
}: {
  user.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC6lmOpmk0XqC7G5n6xBMVol8Div9PNpRrcQ211uwFh0 yunfachi@mitama"];

  sops.secrets."wireguard/clients/mitama/privateKey".owner = username;

  yunfachi = {
    services.wireguard.clients.${hostName} = {
      ip = "10.0.0.101";
      publicKey = decryptSecret "wireguard/clients/mitama/publicKey";
    };
  };
}
