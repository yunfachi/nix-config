{
  module-functions,
  hm,
  pkgs,
  ...
}:
module-functions.module "programs" "codium" {
  hm.programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };
}
// {
  imports = [
    ./extensions.nix
    ./settings.nix
  ];
}
