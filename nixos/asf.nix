{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.yunfachi-nixos.archisteamfarm;
in {
  config = lib.mkIf cfg.enable {
    systemd.user.services.archisteamfarm = {
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        ExecStart = "${pkgs.ArchiSteamFarm}/bin/${pkgs.ArchiSteamFarm.meta.mainProgram} --no-restart --process-required --service --system-required";
        Restart = "on-success";
        RestartSec = 1;
      };

      unitConfig = {
        After = "network.target";
      };
    };

    services.archisteamfarm = {
      enable = true;
      web-ui.enable = false;

      bots = {
        yunfachi = {
          # TODO: lol
          username = builtins.readFile /.yunfachi.username.asf;
          passwordFile = /.yunfachi.password.asf;
          settings = {
            GamesPlayedWhileIdle = [774171];
          };
        };
      };

      settings = {
      };
    };
  };
}
