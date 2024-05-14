{
  module-functions,
  config,
  pkgs,
  username,
  ...
}:
module-functions.module "infras" "deshiro" {
  sops = {
    secrets = {
      "infras/deshiro/bot_token".restartUnits = ["deshiro-bot.service"];
      "infras/deshiro/db_password".restartUnits = ["deshiro-bot.service"];
    };
    templates."infras/deshiro/env" = {
      content = ''
        BOT_TOKEN=${config.sops.placeholder."infras/deshiro/bot_token"}
        DB_PASSWORD=${config.sops.placeholder."infras/deshiro/db_password"}
      '';
      owner = username;
    };
  };

  systemd.services = let
    repo_path = "/home/${username}/deshiro-bot";
    repo_url = "ssh://git@github.com/deshiro/bot.git";
    key_path = "/home/${username}/.ssh/id_ed25519";
  in {
    deshiro-bot-update = {
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

        ln -sf "${config.sops.templates."infras/deshiro/env".path}" "${repo_path}/.env"
      '';
    };

    deshiro-bot = {
      enable = true;

      requires = ["network.target" "deshiro-bot-update.service"];
      after = ["network.target" "deshiro-bot-update.service"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "simple";
        User = username;
        WorkingDirectory = repo_path;
        Restart = "always";
      };

      path = [pkgs.deno];
      script = ''
        ln -sf ${config.sops.templates."infras/deshiro/env".path} .env
        deno task start
      '';
    };
  };
}
