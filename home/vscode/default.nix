{
  pkgs-unstable,
  ...
}: {
  imports = [
    ./settings.nix
    ./extensions.nix
  ];

  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscodium;
  };
}
