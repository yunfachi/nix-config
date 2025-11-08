{
  delib,
  lib,
  decryptSecret,
  ...
}:
delib.module {
  name = "services.xray";

  options =
    { cfg, ... }:
    {
      services.xray.client = with delib; {
        id = noDefault (enumOption cfg.server.clientIds null);
        shortId = noDefault (enumOption cfg.server.shortIds null);
      };
    };

  nixos.ifEnabled =
    {
      myconfig,
      cfg,
      ...
    }:
    lib.mkIf (cfg.type == "client") {
      services.xray.settings = {
        inbounds = [
          {
            tag = "socks-proxy";

            listen = "127.0.0.1";
            port = 10808;
            protocol = "socks";
          }
          {
            tag = "http-proxy";

            listen = "127.0.0.1";
            port = 10818;
            protocol = "http";
          }
        ]
        ++ (lib.optional myconfig.services.wireguard.enable (
          let
            port = myconfig.services.wireguard.server.port;
          in
          {
            tag = "wireguard";

            listen = "127.0.0.1";
            port = port;
            protocol = "dokodemo-door";

            settings = {
              address = "127.0.0.1";
              port = port;
              network = "udp";
            };
          }
        ));

        outbounds = [
          {
            protocol = "vless";
            tag = "proxy";

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
                serverName = "ya.ru";
                publicKey = cfg.server.publicKey;
                shortId = cfg.client.shortId;
              };
            };
          }
          {
            tag = "direct";
            protocol = "freedom";
          }
          {
            tag = "block";
            protocol = "blackhole";
          }
        ];

        routing = {
          domainStrategy = "IPIfNonMatch";
          rules = [
            {
              type = "field";
              domain = [
                "geosite:private"
                "regexp:.ru$"
              ]
              ++ (builtins.fromJSON (decryptSecret "services/xray/direct_domains"));
              outboundTag = "direct";
            }
            {
              type = "field";
              ip = [ "10.0.1.0/24" ];
              outboundTag = "proxy";
            }
            {
              type = "field";
              ip = [ "127.0.0.1" ];
              port = 51820;
              outboundTag = "proxy";
            }
            {
              type = "field";
              ip = [
                "geoip:ru"
                "geoip:private"
              ];
              outboundTag = "direct";
            }
            {
              type = "field";
              domain = [ "dnsQuery" ];
              outboundTag = "proxy";
            }
          ];
        };
      };
    };
}
