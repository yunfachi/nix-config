{
  delib,
  pkgs,
  homeconfig,
  host,
  ...
}:
delib.module {
  name = "programs.nh";

  options = delib.singleEnableOption host.cliFeatured;

  home.ifEnabled.home.packages = [pkgs.nh];
  nixos.ifEnabled.environment.variables.FLAKE = "${homeconfig.home.homeDirectory}/nix-config"; #FIXME: looks terrible
}
