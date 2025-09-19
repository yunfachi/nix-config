{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.nixfmt";

  options = delib.singleEnableOption host.cliFeatured;

  home.ifEnabled.home.packages = [ pkgs.nixfmt ];
}
