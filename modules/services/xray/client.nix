{
  delib,
  lib,
  ...
}:
delib.module {
  name = "services.xray";

  options = {cfg, ...}: {
    services.xray.client = with delib; {
      id = noDefault (enumOption cfg.server.clientIds null);
      shortId = noDefault (enumOption cfg.server.shortIds null);
    };
  };

  nixos.ifEnabled = {
    myconfig,
    cfg,
    ...
  }:
    lib.mkIf (cfg.type == "client") {
      services.xray.settings = {
        inbounds =
          [
            {
              #tag = "proxy";

              listen = "127.0.0.1";
              port = 10808;
              protocol = "socks";

              settings = {
                udp = true;
              };

              sniffing = {
                enabled = true;
                destOverride = [
                  "http"
                  "tls"
                  "quic"
                ];
                routeOnly = true;
              };
            }
          ]
          ++ (lib.optional myconfig.services.wireguard.enable (let
            port = myconfig.services.wireguard.server.port;
          in {
            tag = "wireguard";

            listen = "127.0.0.1";
            port = port;
            protocol = "dokodemo-door";

            settings = {
              address = "127.0.0.1";
              port = port;
              network = "udp";
            };
          }));

        outbounds = [
          {
            tag = "proxy";
            protocol = "vless";

            settings = {
              vnext = [
                {
                  address = cfg.server.ip;
                  port = cfg.server.port;
                  users = [
                    {
                      id = cfg.client.id;
                      encryption = "none";
                      flow = "xtls-rprx-vision";
                      #flow = "";
                    }
                  ];
                }
              ];
            };

            streamSettings = {
              network = "tcp";
              security = "reality";
              realitySettings = {
                fingerprint = "chrome";
                serverName = "www.google.com";
                publicKey = cfg.server.publicKey;
                shortId = cfg.client.shortId;
              };
            };
          }
        ];
      };
    };
}
