{
  config,
  lib,
  type,
  ...
}:
with lib; let
  cfg = config.yunfachi;
in {
  options.yunfachi = {
    audio.enable = lib.mkEnableOption "audio (pipewire)" // {default = type == "desktop";};

    grub.enable = lib.mkEnableOption "grub" // {default = true;};
    wireguard = {
      enable = mkEnableOption "wireguard" // {default = type == "desktop";};
      type = mkOption {
        type = types.enum ["server" "client"];
        default =
          if type == "desktop"
          then "client"
          else "server";
        example = "client";
        description = "";
      };

      privateKeyFile = mkOption {
        type = types.str;
        default = "/etc/wireguard/private.key";
        description = "The private key of the current host.";
      };
      routedIPs = mkOption {
        type = types.listOf (types.str);
        default = ["0.0.0.0/0" "::/0"];
        example = [];
        description = "A list of IP addresses or CIDR blocks that will be routed through the VPN. Only needed for the client.";
      };

      server = {
        ip = mkOption {
          type = types.str;
          default = null;
          example = "1.1.1.1";
          description = "IP address of the server.";
        };
        port = mkOption {
          type = types.port;
          default = 51820;
          example = 51820;
          description = "Port of the server.";
        };
        interface = mkOption {
          type = types.str;
          default = null;
          example = "eno3";
          description = "The name of the external network interface.";
        };
        tunnel = mkOption {
          type = types.str;
          default = null;
          example = "10.0.0.1";
          description = "IP address and subnet of the client's end of the tunnel interface.";
        };
        publicKey = mkOption {
          type = types.str;
          default = null;
          example = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
          description = "The public key of the server.";
        };
      };

      clients = mkOption {
        type = types.attrsOf (types.submodule {
          options = {
            ip = mkOption {
              type = types.str;
              default = null;
              example = "10.0.0.2";
              description = "IP address of the client.";
            };
            publicKey = mkOption {
              type = types.str;
              default = null;
              example = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
              description = "The public key of the client.";
            };
          };
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
    };

    archisteamfarm.enable = mkEnableOption "archisteamfarm" // {default = false;};
  };
}
