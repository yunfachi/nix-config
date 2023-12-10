{
  config,
  lib,
  inputs,
  system,
  ...
}: let
  cfg = config.yunfachi.vscodium;
in {
  config = lib.mkIf cfg.enable {
    programs.vscode = {
      extensions = with inputs.vscode-extensions.extensions.${system}.vscode-marketplace; [
        beardedbear.beardedtheme # Theme
        beardedbear.beardedicons # Icons

        wakatime.vscode-wakatime # WakaTime
        leonardssh.vscord # Discord RPC

        kamadorueda.alejandra # Nix Formatter
        jnoortheen.nix-ide # Nix Syntax Highlight and more

        github.vscode-github-actions # Github Actions

        github.remotehub # Github remote repositories
        ms-vscode-remote.remote-ssh # SSH

        github.copilot # Copilot AI
        github.copilot-chat # Copilot AI chat
        github.copilot-labs # Copilot AI labs
        github.heygithub # Copilot AI voice
      ];
    };
  };
}
