{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "services" "wireguard" (cfg: {
    enable = enableOption "wireguard" host.isDesktop;
    type = enumOption "type" (
      if host.isDesktop
      then "client"
      else "server"
    ) ["server" "client"];

    client = enumOption "client name. Defaults to the host name" host.name (builtins.attrNames cfg.clients);
    privateKeyFile = textOption "private key file" "/etc/wireguard/private.key";
    routedIPs = listOption "routed IPs" ["0.0.0.0/0" "::/0"] types.str;

    server = {
      ip = textOption "IP address of the server" null;
      port = portOption "port of the server" 51820;
      interface = textOption "the name of the external network interface" null;
      tunnel = textOption "IP address and subnet of the client's end of the tunnel interface" "10.0.0.1";
      publicKey = textOption "the public key of the server" "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };

    clients = mkOption {
      type = types.attrsOf (submoduleOption {
        ip = textOption "IP address of the client" null;
        publicKey = textOption "the public key of the client" "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      });
      default = {};
      example = {
        "host" = {
          ip = "10.1.1.2";
          publicKey = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        };
      };
      description = "Peer settings. Must be in shared to work correctly.";
    };
  })
