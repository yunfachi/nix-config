{
  module-functions,
  hm,
  vscode-extensions,
  ...
}:
module-functions.module "programs" "codium" {
  hm.programs.vscode = {
    extensions = with vscode-extensions; [
      beardedbear.beardedtheme # Theme
      beardedbear.beardedicons # Icons

      wakatime.vscode-wakatime # WakaTime
      leonardssh.vscord # Discord RPC

      kamadorueda.alejandra # Nix Formatter
      jnoortheen.nix-ide # Nix Syntax Highlight and more

      github.vscode-github-actions # Github Actions

      github.copilot # Copilot AI
      github.copilot-chat # Copilot AI chat
    ];
  };
}
