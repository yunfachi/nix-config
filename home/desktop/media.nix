{pkgs, ...}: {
  home.packages = with pkgs; [
    ffmpeg-full

    viu
    imagemagick
  ];
}
