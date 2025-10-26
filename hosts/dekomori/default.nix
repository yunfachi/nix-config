{
  delib,
  decryptHostSecretFile,
  decryptHostSecret,
  wireguardLocalAddress,
  lib,
  ...
}:
delib.host {
  name = "dekomori";

  rice = "marukutekurai";
  type = "server";
  features = [ "cli" ];

  nixos = {
    systemd.services.postgresql.after = [ "wg-quick-wg0.service" ];

    boot.loader.grub.device = "/dev/vda";
    boot.loader.grub.devices = lib.mkForce [ "/dev/vda" ];
    zramSwap.enable = true;
  };

  myconfig =
    { name, ... }:
    {
      infras = {
        changelog.enable = true;
        deshiro.enable = true;
      };

      programs = {
        git.signingKey = "0x3347EA00F28111FC";
      };

      services = {
        archisteamfarm.enable = true;

        postgresql = {
          enable = true;

          openFirewall = true;
          listen_addresses = [ wireguardLocalAddress ];
        };

        vaultwarden = {
          enable = true;
          database = {
            backend = "postgresql";
            password = decryptHostSecret name "services/vaultwarden/postgresql/password";
          };
        };

        wireguard = {
          enable = true;
          privateKeyFile = decryptHostSecretFile name "services/wireguard/privateKey";
        };

        xray = {
          enable = true;
          server.privateKey = decryptHostSecret name "services/xray/privateKey";
        };
      };
    };
}
