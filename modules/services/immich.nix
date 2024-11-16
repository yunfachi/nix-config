{
  delib,
  wireguardLocalAddress,
  ...
}:
delib.module {
  name = "services.immich";

  options.services.immich = with delib; {
    enable = boolOption false;

    host = strOption (
      if wireguardLocalAddress != null
      then wireguardLocalAddress
      else "localhost"
    );
    openFirewall = boolOption true;

    settings = allowNull (attrsOption null);
    mediaLocation = pathOption "/var/lib/immich";
  };

  nixos.ifEnabled = {cfg, ...}: {
    services.immich = {
      enable = true;

      inherit (cfg) host openFirewall settings mediaLocation;
    };

    users.users.immich.extraGroups = ["video" "render"];
  };
}
