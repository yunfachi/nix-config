{
  delib,
  decryptSecret,
  ...
}:
delib.module {
  name = "services.navidrome";

  options.services.navidrome = with delib; {
    enable = boolOption false;

    openFirewall = boolOption false;
    address = strOption "127.0.0.1";
    port = portOption 4533;

    folder = noDefault (strOption null);
  };

  myconfig.ifEnabled.persist.directories = ["/var/lib/navidrome"];

  nixos.ifEnabled = {cfg, ...}: {
    services.navidrome = {
      inherit (cfg) openFirewall;
      enable = true;

      settings = {
        Address = cfg.address;
        Port = cfg.port;
        MusicFolder = cfg.folder;
        LastFM = {
          ApiKey = decryptSecret "services/navidrome/lastfm/apikey";
          Secret = decryptSecret "services/navidrome/lastfm/secret";
        };
      };
    };
  };
}
