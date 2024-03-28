{
  module-functions,
  pkgs,
  lib,
  host,
  ...
}:
module-functions.module "services" "wireguard" (cfg: {
  networking = {
    firewall = lib.mkIf (cfg.type == "server") {
      allowedUDPPorts = [cfg.server.port];
    };
    nat = lib.mkIf (cfg.type == "server") {
      enable = true;
      enableIPv6 = false;
      externalInterface = cfg.server.interface;
      internalInterfaces = ["wg0"];
    };

    wg-quick.interfaces.wg0 =
      {inherit (cfg) privateKeyFile;}
      // (
        if cfg.type == "server"
        then {
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

          peers = builtins.map (
            client: {
              publicKey = client.publicKey;
              allowedIPs = ["${client.ip}/32"];
            }
          ) (builtins.attrValues cfg.clients);
        }
        else {
          address = [cfg.clients."${host.name}".ip];

          peers = [
            {
              publicKey = "${cfg.server.publicKey}";
              allowedIPs = cfg.routedIPs;
              endpoint = "${cfg.server.ip}:${builtins.toString cfg.server.port}";
              persistentKeepalive = 20;
            }
          ];
        }
      );
  };
})
