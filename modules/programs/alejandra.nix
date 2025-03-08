{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.alejandra";

  options = delib.singleEnableOption host.cliFeatured;

  home.ifEnabled.home.packages = [pkgs.alejandra];
}
