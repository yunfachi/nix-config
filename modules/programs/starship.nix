{
  delib,
  lib,
  pkgs,
  homeconfig,
  host,
  ...
}:
delib.module {
  name = "programs.starship";

  options = delib.singleEnableOption host.cliFeatured;

  nixos.ifEnabled = {
    programs = {
      bash.promptInit = ''
        if [[ ! -f "$HOME/.config/starship.toml" ]]; then
          export STARSHIP_CONFIG="${homeconfig.xdg.configHome}/starship.toml"
        fi
        eval "$(${lib.getExe pkgs.starship} init bash)"
      '';
      fish.promptInit = ''
        if not test -f "$HOME/.config/starship.toml";
          set -x STARSHIP_CONFIG "${homeconfig.xdg.configHome}/starship.toml"
        end
        eval "$(${lib.getExe pkgs.starship} init fish)"
      '';
      zsh.promptInit = ''
        if [[ ! -f "$HOME/.config/starship.toml" ]]; then
          export STARSHIP_CONFIG="${homeconfig.xdg.configHome}/starship.toml"
        fi
        eval "$(${lib.getExe pkgs.starship} init zsh)"
      '';
    };
  };

  home.ifEnabled.programs.starship = {
    enable = true;

    settings = {
      format = lib.concatStrings ["$username" "$hostname" "$battery" "$nix_shell" "$directory" "$git_branch" "$cmd_duration" "$character"];

      add_newline = true;
      scan_timeout = 10;

      character = {
        success_symbol = "[❯](bold dimmed green)";
        error_symbol = "[❯](bold dimmed red)";
      };
      username = {
        style_user = "bold dimmed green";
        style_root = "bold dimmed red";
        format = "[$user]($style) at ";
      };
      directory = {
        format = "in [$path]($style)[$read_only]($read_only_style) ";
        style = "bold dimmed green";
        read_only = "*";
        read_only_style = "dimmed red";
      };
      git_branch = {
        style = "bold dimmed green";
        format = "on [$branch]($style) ";
        ignore_branches = ["master" "main"];
      };
      cmd_duration = {
        min_time = 1000;
        style = "bold dimmed green";
        format = "took [$duration]($style) ";
      };
      hostname = {
        ssh_only = false;
        ssh_symbol = "*";
        format = "[$hostname$ssh_symbol]($style) ";
        style = "bold dimmed green";
      };
      battery = {
        format = "with [$percentage]($style) ";
        display = [
          {
            threshold = 100;
            style = "bold dimmed green";
          }
          {
            threshold = 30;
            style = "bold dimmed red";
          }
        ];
      };
      nix_shell = {
        style = "bold purple";
        format = "via [$state( \($name\))]($style) ";
      };
    };
  };
}
