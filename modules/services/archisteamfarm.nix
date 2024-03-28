{
  module-functions,
  config,
  ylib,
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

    #TODO: remove after https://github.com/NixOS/nixpkgs/pull/299656
    ipcSettings.Kestrel = {};

    settings = {
      DefaultBot = "yunfachi";
      SteamOwnerID = "76561198967857357";
    };
    bots = {
      yunfachi = {
        username = ylib.readCanonicalFile config.sops.secrets."services/archisteamfarm/bots/yunfachi/username".path;
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
