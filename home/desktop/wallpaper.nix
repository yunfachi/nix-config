{
  wallpapers,
  config,
  ...
}: {
  home.file."media/wallpapers".source = wallpapers;
  home.file.".local/bin/wallpaper_random" = {
    source = "${wallpapers}/random.sh";
    executable = true;
  };
}
