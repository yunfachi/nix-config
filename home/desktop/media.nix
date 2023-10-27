{
  pkgs,
  pkgs-yunfachi,
  ...
}: {
  home.packages = with pkgs;
    [
      ffmpeg-full

      viu
      imagemagick
    ]
    ++ [
      pkgs-yunfachi.shikimori
    ];
}
