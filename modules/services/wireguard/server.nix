{
  delib,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "services.wireguard";

  nixos.ifEnabled = {cfg, ...}:
    lib.mkIf (cfg.type == "server") {
      networking = {
        firewall.allowedUDPPorts = [cfg.server.port];

        nat = {
          enable = true;
          enableIPv6 = false;
          externalInterface = cfg.server.interface;
          internalInterfaces = ["wg0"];
        };

        wg-quick.interfaces.wg0 = {
          inherit (cfg) privateKeyFile;
          address = ["${cfg.server.tunnel}/24"];
          listenPort = cfg.server.port;

          postUp = ''
            ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
            ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -o ${cfg.server.interface} -j MASQUERADE
          '';
          preDown = ''
            ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
            ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -o ${cfg.server.interface} -j MASQUERADE
          '';

          peers = map (
            client: {
              publicKey = client.publicKey;
              allowedIPs = ["${client.ip}/32"];
            }
          ) (builtins.attrValues cfg.clients);
        };
      };
    };
}
