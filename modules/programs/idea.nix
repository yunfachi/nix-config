{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.idea";

  options = delib.singleEnableOption host.guiFeatured;

  myconfig.ifEnabled.persist.user.directories = [
    ".config/JetBrains"
    ".local/share/JetBrains"
    ".cache/JetBrains"
  ];

  home.ifEnabled.home.packages = [ pkgs.jetbrains.idea-community-src ];
}
