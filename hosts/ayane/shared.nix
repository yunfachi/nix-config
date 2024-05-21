{hostName}: {
  username,
  user,
  decryptSecret,
  ...
}: {
  user.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINbky4toRn5dD27HPOsxFzJm4HbByfdi7WlxeatA9T/Y yunfachi@ayane"];

  sops.secrets."wireguard/clients/ayane/privateKey".owner = username;

  yunfachi = {
    services.wireguard.clients.${hostName} = {
      ip = "10.0.0.101";
      publicKey = decryptSecret "wireguard/clients/ayane/publicKey";
    };
  };
}
