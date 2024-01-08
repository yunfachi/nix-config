{secrets, ...}: {
  yunfachi = {
    wireguard = {
      server = {
        ip = secrets.yunfachi.wireguard.server.ip;
        port = secrets.yunfachi.wireguard.server.port;
        interface = "ens3";
        tunnel = "10.0.0.1";
        publicKey = secrets.yunfachi.wireguard.server.publicKey;
      };

      clients = {
        "a52" = {
          ip = "10.0.0.101";
          publicKey = secrets.yunfachi.wireguard.clients."a52".publicKey;
        };
        "p11" = {
          ip = "10.0.0.102";
          publicKey = secrets.yunfachi.wireguard.clients."p11".publicKey;
        };
        "t12" = {
          ip = "10.0.0.103";
          publicKey = secrets.yunfachi.wireguard.clients."t12".publicKey;
        };
      };

      routedIPs = [
        "192.30.252.0/22"
        "185.199.108.0/22"
        "140.82.112.0/20"
        "143.55.64.0/20"
        "2a0a:a440::/29"
        "2606:50c0::/32"
      ];
    };
  };
}
