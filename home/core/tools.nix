{pkgs, ...}: {
  home.packages = with pkgs; [
    tree
    
    ranger
  ];
}