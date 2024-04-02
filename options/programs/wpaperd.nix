{
  option-functions,
  host,
  data,
  ...
}:
with option-functions;
  option "programs" "wpaperd" {
    enable = enableOption "wpaperd" host.isDesktop;
    wallpapers =
      listOption "wallpapers" data.wallpapers
      (submoduleOption {
        url = textOption "wallpaper url" null;
        hash = textOption "wallpaper hash" "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      });
  }
