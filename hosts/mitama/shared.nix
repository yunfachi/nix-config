{
  delib,
  decryptSecret,
  ...
}:
delib.host {
  name = "mitama";

  shared.myconfig = {name, ...}: {
    services = {
      sshd = {
        authorizedKeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHN/Gb1Q+5daqcOIEOTBxonnwV2DDrFvcfK6i3pDhdEo yunfachi@ayane"];
      };

      wireguard.clients.${name} = {
        ip = "10.0.0.102";
        publicKey = decryptSecret "services/wireguard/clients/${name}/publicKey";
      };
    };
  };
}
