{
  delib,
  host,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "services.wireguard";

  options = {
    myconfig,
    cfg,
    ...
  }: {
    services.wireguard = with delib; {
      enable = boolOption host.isDesktop;
      type = enumOption ["client" "server"] (
        if host.isDesktop
        then "client"
        else "server"
      );

      privateKeyFile = noDefault (strOption null);
      routedIPs = listOfOption str (
        if !myconfig.services.xray.enable
        then ["0.0.0.0/0" "::/0"]
        else ["10.0.1.0/24"]
      );

      client = allowNull (submoduleOption
        {
          options.name = enumOption (builtins.attrNames cfg.clients) host.name;
        } (
          if cfg.type == "server"
          then null
          else {}
        ));

      server = {
        ip = noDefault (strOption null);
        port = portOption 51820;
        openFirewall = boolOption true;

        hostname = noDefault (strOption null);
        interface = strOption "wg0";
        tunnel = strOption "10.0.1.1";
        publicKey = noDefault (strOption null);
      };

      clients = attrsOfOption (submodule {
        options = {
          ip = noDefault (strOption null);
          publicKey = noDefault (strOption null);
        };
      }) {};
    };
  };

  myconfig.always = {cfg, ...}: {
    args.shared.wireguardLocalAddress =
      if cfg.enable
      then
        (
          if cfg.type == "client" && cfg.client != null
          then cfg.clients.${cfg.client.name}.ip
          else cfg.server.tunnel
        )
      else null;
  };

  myconfig.ifEnabled = {cfg, ...}: {
    networking.hosts =
      {
        ${cfg.server.tunnel} = [cfg.server.hostname];
      }
      // lib.concatMapAttrs (name: value: {${value.ip} = [name];}) cfg.clients;
  };

  home.ifEnabled.home.packages = [pkgs.wireguard-tools];
}
