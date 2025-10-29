{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.nmap";

  options = delib.singleEnableOption (host.cliFeatured && host.hackingFeatured);

  home.ifEnabled.home.packages = [pkgs.nmap];
}
