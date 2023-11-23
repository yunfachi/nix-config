{pkgs, ...}: {
  home.packages = with pkgs; [
    ranger

    tree

    gnumake
  ];
}