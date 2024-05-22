{hostName}: {
  username,
  user,
  decryptSecret,
  ...
}: {
  user.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHN/Gb1Q+5daqcOIEOTBxonnwV2DDrFvcfK6i3pDhdEo yunfachi@ayane"];

  sops.secrets."wireguard/clients/ayane/privateKey".owner = username;

  yunfachi = {
    services.wireguard.clients.${hostName} = {
      ip = "10.0.0.102";
      publicKey = decryptSecret "wireguard/clients/ayane/publicKey";
    };
  };
}
