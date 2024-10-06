{
  delib,
  decryptHostSecretFile,
  wireguardLocalAddress,
  ...
}:
delib.host {
  name = "dekomori";

  rice = "yami";
  type = "server";

  nixos = {
    systemd.services.postgresql.after = ["wg-quick-wg0.service"];
  };

  myconfig = {name, ...}: {
    infras = {
      changelog.enable = true;
      deshiro.enable = true;
    };

    programs = {
      # git.signingKey = "0x";
    };

    services = {
      archisteamfarm.enable = true;

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
