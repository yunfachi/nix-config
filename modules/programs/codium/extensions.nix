{
  delib,
  pkgs,
  inputs,
  lib,
  ...
}:
delib.module {
  name = "programs.codium";

  home.ifEnabled =
    { cfg, ... }:
    let
      vscode-extensions = inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace;
    in
    {
      programs.vscode.profiles.default.extensions = with vscode-extensions; [
        beardedbear.beardedtheme # Theme
        beardedbear.beardedicons # Icons

        (lib.mkIf cfg.extensions.wakatime wakatime.vscode-wakatime) # WakaTime
        leonardssh.vscord # Discord RPC

        (lib.mkIf cfg.extensions.nixfmt brettm12345.nixfmt-vscode) # Nix Formatter
        jnoortheen.nix-ide # Nix Syntax Highlight and more
      ];
    };
}
