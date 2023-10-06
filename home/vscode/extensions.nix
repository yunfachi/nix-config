{
  pkgs-unstable,
  nix-vscode-extensions,
  ...
}: {
  programs.vscode = {
    extensions = with nix-vscode-extensions.extensions.${pkgs-unstable.system}.vscode-marketplace; [
      wakatime.vscode-wakatime # WakaTime
      beardedbear.beardedtheme # Theme
      beardedbear.beardedicons # Icons
      leonardssh.vscord # Discord RPC
      kamadorueda.alejandra # Nix Formatter
      jnoortheen.nix-ide # Nix Syntax Highlight and more
    ];
  };
}
