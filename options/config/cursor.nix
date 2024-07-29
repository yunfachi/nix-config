{
  option-functions,
  host,
  pkgs,
  ...
}:
with option-functions;
  option null "cursor" {
    enable = enableOption "cursor" host.isDesktop;
    name = textOption "cursor name" "Bibata-Modern-Ice";
    size = numberOption "cursor size" 24;
    package = packageOption "package providing the cursor theme" pkgs.bibata-cursors;
  }
