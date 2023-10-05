{
  wallpapers,
  config,
  ...
}: {
  home.file.".config/wallpapers".source = wallpapers;
  home.file.".local/bin/wallpaper_random" = {
    source = "${wallpapers}/random.sh";
    executable = true;
  };
}
