{pkgs, ...}: {
  home.packages = with pkgs; [
    minecraft
    lunar-client
  ];
}