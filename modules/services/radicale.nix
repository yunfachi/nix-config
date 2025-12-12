{
  delib,
  wireguardLocalAddress,
  ...
}:
delib.module {
  name = "services.radicale";

  options = {
    myconfig,
    cfg,
    ...
  }: {
    services.radicale = with delib; {
      enable = boolOption false;
      address = strOption (
        if wireguardLocalAddress != null
        then wireguardLocalAddress
        else "127.0.0.1"
      );
      port = intOption 5232;
    };
  };

  myconfig.ifEnabled = {
    persist.directories = ["/etc/radicale" "/var/lib/radicale"];
  };

  nixos.ifEnabled = {cfg, ...}: {
    networking.firewall.allowedTCPPorts = [cfg.port];

    services.radicale = {
      enable = true;
      settings = {
        server.hosts = [ "${cfg.address}:${toString cfg.port}" ];

        auth = {
          type = "htpasswd";
          htpasswd_filename = "/etc/radicale/users";
          htpasswd_encryption = "bcrypt";
        };   
      };
    };
  };
}
