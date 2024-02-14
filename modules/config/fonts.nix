{
  module-functions,
  config,
  pkgs,
  ...
}:
module-functions.module null "fonts" {
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
      font-awesome
      material-design-icons
      nerdfonts
    ];
  };
}
