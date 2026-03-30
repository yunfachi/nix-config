{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.steam";

  options = delib.singleEnableOption (host.guiFeatured && host.gamingFeatured);

  myconfig.ifEnabled.persist.user.directories = [
    ".steam"
    ".local/share/Steam"
  ];

  home.ifEnabled.home.packages = [ pkgs.steam ];

  # GTA 5 fix
  nixos.ifEnabled.networking.hosts."0.0.0.0" = [
    "paradise-s1.battleye.com"
    "test-s1.battleye.com"
    "paradiseenhanced-s1.battleye.com"
  ];
}
