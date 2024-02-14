{
  module-functions,
  hm,
  lib,
  ...
}:
module-functions.module "programs" "starship" (cfg: {
  hm.programs.starship = {
    enable = true;

    enableFishIntegration = false;
    enableIonIntegration = false;
    enableNushellIntegration = false;
    enableZshIntegration = false;

    settings = {
      format = "$hostname$nix_shell$character";

      add_newline = true;
      scan_timeout = 10;

      character = {
        success_symbol = "[❯](bold dimmed green)";
        error_symbol = "[❯](bold red)";
      };
      hostname = {
        ssh_only = false;
        ssh_symbol = "*";
        format = "[$ssh_symbol$hostname]($style) ";
        style = "bold dimmed green";
      };
      nix_shell = {
        style = "bold purple";
        format = "via [$state( \($name\))]($style) ";
      };
    };
  };
})
