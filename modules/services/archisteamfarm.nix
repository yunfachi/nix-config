{
  delib,
  wireguardLocalAddress,
  decryptSecret,
  decryptSecretFile,
  lib,
  ...
}:
delib.module {
  name = "services.archisteamfarm";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    networking.firewall.allowedTCPPorts = [1242];

    services.archisteamfarm = {
      enable = true;
      web-ui.enable = true;

      settings = {
        DefaultBot = "yunfachi";
        SteamOwnerID = 76561198967857357;
      };

      ipcSettings.Kestrel.Endpoints = {
        LocalHost-HTTP.Url = "http://127.0.0.1:1242";
        WireGuard-HTTP.Url = lib.mkIf (wireguardLocalAddress != null) "http://${wireguardLocalAddress}:1242";
      };
      ipcPasswordFile = decryptSecretFile "services/archisteamfarm/ipcPassword";

      bots = {
        yunfachi = {
          username = decryptSecret "services/archisteamfarm/bots/yunfachi/username";
          passwordFile = decryptSecretFile "services/archisteamfarm/bots/yunfachi/password";
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
  };
}
