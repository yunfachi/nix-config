{aagl, ...}: {
  home.packages = with aagl.packages.x86_64-linux; [
    anime-game-launcher
  ];
}