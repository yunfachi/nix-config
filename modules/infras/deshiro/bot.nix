{
  delib,
  constants,
  pkgs,
  homeconfig,
  decryptSecret,
  ...
}:
delib.module {
  name = "infras.deshiro";

  nixos.ifEnabled = {myconfig, ...}: {
    systemd.services = let
      repo_path = "/${homeconfig.home.homeDirectory}/infras/deshiro-bot";
      repo_url = "ssh://git@github.com/deshiro/bot.git";
      key_path = "/${homeconfig.home.homeDirectory}/.ssh/id_ed25519";

      env = builtins.toFile "infras-deshiro-env" ''
        ${decryptSecret "infras/deshiro/env"}
        DB_HOSTNAME=/run/postgresql
        DB_HOST_TYPE=socket
        DB_PORT=${toString myconfig.services.postgresql.port}
      '';
    in {
      deshiro-bot-update = {
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

          ln -sf "${env}" "${repo_path}/.env"
        '';
      };

      deshiro-bot = {
        enable = true;

        requires = ["network.target" "deshiro-bot-update.service"];
        after = ["network.target" "deshiro-bot-update.service"];
        wantedBy = ["multi-user.target"];

        serviceConfig = {
          Type = "simple";
          User = constants.username;
          WorkingDirectory = repo_path;
          Restart = "always";
        };

        path = [pkgs.deno];
        script = ''
          ln -sf ${env} .env
          deno task start
        '';
      };
    };
  };
}
