{
  delib,
  host,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "programs.burpsuite";

  options = delib.singleEnableOption (host.guiFeatured && host.hackingFeatured);

  myconfig.ifEnabled.persist.user.directories = [
    ".BurpSuite"
    ".java/.userPrefs/burp/"
  ];

  home.ifEnabled.home.packages = [inputs.burpsuitepro.packages.${pkgs.system}.default];
}
