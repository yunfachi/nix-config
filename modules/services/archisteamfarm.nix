{
  module-functions,
  config,
  decryptSecret,
  ...
}:
module-functions.module "services" "archisteamfarm" {
  sops.secrets."services/archisteamfarm/bots/yunfachi/username" = {
    restartUnits = ["archisteamfarm.service"];
    owner = "yunfachi";
  };
  sops.secrets."services/archisteamfarm/bots/yunfachi/password" = {
    restartUnits = ["archisteamfarm.service"];
    owner = "archisteamfarm";
  };

  services.archisteamfarm = {
    enable = true;
    web-ui.enable = false;

    settings = {
      DefaultBot = "yunfachi";
      SteamOwnerID = 76561198967857357;
    };
    bots = {
      yunfachi = {
        username = decryptSecret "services/archisteamfarm/bots/yunfachi/username";
        passwordFile = config.sops.secrets."services/archisteamfarm/bots/yunfachi/password".path;
        settings = {
          AcceptGifts = true;
          FarmingOrders = [5];
          FarmingPreferences = 128;
          GamesPlayedWhileIdle = [774171];
          OnlineStatus = 7;
        };
      };
    };
  };
}
