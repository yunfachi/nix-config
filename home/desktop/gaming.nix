{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    lunar-client
  ];
}
