{
  delib,
  constants,
  pkgs,
  homeconfig,
  ...
}:
delib.module {
  name = "infras.changelog";

  nixos.ifEnabled = {myconfig, ...}: {
    systemd.services = let
      repo_path = "/${homeconfig.home.homeDirectory}/infras/changelog-bot";
      repo_url = "ssh://git@github.com/changelog-bot/bot.git";
      key_path = "/${homeconfig.home.homeDirectory}/.ssh/id_ed25519";
    in {
      changelog-bot-update = {
        enable = true;

        requires = ["network.target"];
        after = ["network.target"];
        wantedBy = ["multi-user.target"];

        serviceConfig = {
          Type = "oneshot";
          User = constants.username;
        };

        path = with pkgs; [openssh git];
        script = ''
          eval `ssh-agent -s`
          ssh-add "${key_path}"

          if [ ! -d "${repo_path}" ]; then
            git clone "${repo_url}" "${repo_path}"
          else
            cd "${repo_path}" || exit
            git pull origin master
          fi
        '';
      };

      changelog-bot = {
        enable = true;

        requires = ["network.target" "changelog-bot-update.service"];
        after = ["network.target" "changelog-bot-update.service"];
        wantedBy = ["multi-user.target"];

        serviceConfig = {
          Type = "simple";
          User = constants.username;
          WorkingDirectory = repo_path;
          Restart = "always";
        };

        path = [
          (pkgs.python3.withPackages (ps:
            with ps; [
              discordpy
              psycopg2
              requests
            ]))
        ];
        script = ''
          python3 bot.py /run/postgresql ${toString myconfig.services.postgresql.port}
        '';
      };
    };
  };
}
