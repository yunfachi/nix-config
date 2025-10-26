{
  delib,
  lib,
  ...
}:
delib.module {
  name = "services.xray";

  options.services.xray.server = with delib; {
    ip = noDefault (strOption null);
    port = portOption 443;
    openFirewall = boolOption true;

    # xray x25519
    privateKey = noDefault (strOption null);
    publicKey = noDefault (strOption null);

    # xray uuid
    clientIds = listOfOption str [ ];
    # openssl rand -hex 8
    shortIds = listOfOption str [ ];
  };

  nixos.ifEnabled =
    { cfg, ... }:
    lib.mkIf (cfg.type == "server") {
      networking.firewall = lib.mkIf cfg.server.openFirewall {
        allowedTCPPorts = [ cfg.server.port ];
        allowedUDPPorts = [ cfg.server.port ];
      };

      services.xray.settings = {
        inbounds = [
          {
            listen = "0.0.0.0";
            port = cfg.server.port;
            protocol = "vless";

            settings = {
              clients = map (id: {
                inherit id;
                flow = "xtls-rprx-vision";
              }) cfg.server.clientIds;
              decryption = "none";
            };

            streamSettings = {
              network = "tcp";
              security = "reality";
              realitySettings = {
                show = false;
                dest = "ya.ru:443";
                xver = 0;
                serverNames = [
                  "ya.ru"
                ];
                privateKey = cfg.server.privateKey;
                shortIds = cfg.server.shortIds;
              };
            };

            /*
                sniffing = {
                enabled = true;
                destOverride = [
                  "http"
                  "tls"
                  "quic"
                ];
                routeOnly = true;
              };
            */
          }
        ];

        outbounds = [
          {
            protocol = "freedom";
            tag = "direct";
          }
        ];
      };
    };
}
