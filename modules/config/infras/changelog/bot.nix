{
  module-functions,
  config,
  lib,
  hm,
  pkgs,
  username,
  ...
}:
module-functions.module "infras" "changelog" {
  systemd.services = let
    repo_path = "/home/${username}/changelog-bot";
    repo_url = "ssh://git@github.com/changelog-bot/bot.git";
    key_path = "/home/${username}/.ssh/id_ed25519";
  in {
    changelog-bot-update = {
      enable = true;

      requires = ["network.target"];
      after = ["network.target"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "oneshot";
        User = username;
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
        User = username;
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
        python3 bot.py
      '';
    };
  };
}
