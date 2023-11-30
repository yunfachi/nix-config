{
  lib,
  pkgs,
  ...
}: {
  imports = map (n: toString ./. + "/${n}") (lib.remove "default.nix" (builtins.attrNames (builtins.readDir ./.)));

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };
}
