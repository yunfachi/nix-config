{
  delib,
  pkgs,
  homeconfig,
  ...
}:
delib.module {
  name = "programs.nh";

  options = delib.singleEnableOption true;

  home.ifEnabled.home.packages = [pkgs.nh];
  nixos.ifEnabled.environment.variables.FLAKE = "${homeconfig.home.homeDirectory}/nix-config"; #FIXME: looks terrible
}
