{ delib, ... }:
delib.module {
  name = "services.dnscrypt";

  options = delib.singleEnableOption true;

  myconfig.ifEnabled = {
    persist.directories = [
      {
        directory = "/var/lib/private/dnscrypt-proxy";
        user = "nobody";
        group = "nogroup";
        mode = "u=rwx,g=rx,o=rx";
      }
    ];

    networking = {
      nameservers = [
        "127.0.0.1"
        "::1"
      ];
    };
  };

  nixos.ifEnabled = {
    services.dnscrypt-proxy2 = {
      enable = true;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };
      };
    };
  };
}
