{
  delib,
  lib,
  ...
}:
delib.module {
  name = "services.wireguard";

  nixos.ifEnabled = {cfg, ...}:
    lib.mkIf (cfg.type == "client") {
      networking.wg-quick.interfaces.wg0 = {
        inherit (cfg) privateKeyFile;
        address = [cfg.clients."${cfg.client.name}".ip];

        peers = [
          {
            publicKey = "${cfg.server.publicKey}";
            allowedIPs = cfg.routedIPs;
            endpoint = "${cfg.server.ip}:${toString cfg.server.port}";
            persistentKeepalive = 20;
          }
        ];
      };
    };
}
