{
  module-functions,
  hm,
  lib,
  ...
}:
module-functions.module "programs" "starship" {
  hm.programs.starship = {
    enable = true;

    enableFishIntegration = false;
    enableIonIntegration = false;
    enableNushellIntegration = false;
    enableZshIntegration = false;

    settings = {
      format = lib.concatStrings ["$hostname" "$nix_shell" "$directory" "$character"];

      add_newline = true;
      scan_timeout = 10;

      character = {
        success_symbol = "[❯](bold dimmed green)";
        error_symbol = "[❯](bold dimmed red)";
      };
      directory = {
        format = "in [$path]($style)[$read_only]($read_only_style) ";
        style = "bold dimmed green";
        read_only = "*";
        read_only_style = "dimmed red";
      };
      hostname = {
        ssh_only = false;
        ssh_symbol = "*";
        format = "[$hostname$ssh_symbol]($style) ";
        style = "bold dimmed green";
      };
      nix_shell = {
        style = "bold purple";
        format = "via [$state( \($name\))]($style) ";
      };
    };
  };
}
