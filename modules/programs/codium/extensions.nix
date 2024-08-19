{
  delib,
  pkgs,
  inputs,
  lib,
  ...
}:
delib.module {
  name = "programs.codium";

  home.ifEnabled = {cfg, ...}: let
    vscode-extensions = inputs.vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
  in {
    programs.vscode.extensions = with vscode-extensions; [
      beardedbear.beardedtheme # Theme
      beardedbear.beardedicons # Icons

      (lib.mkIf cfg.extensions.wakatime wakatime.vscode-wakatime) # WakaTime
      leonardssh.vscord # Discord RPC

      (lib.mkIf cfg.extensions.alejandra kamadorueda.alejandra) # Nix Formatter
      jnoortheen.nix-ide # Nix Syntax Highlight and more
    ];
  };
}
