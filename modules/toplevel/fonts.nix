{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "fonts";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled = {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      noto-fonts

      # japanese
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans

      # icons
      font-awesome
      material-design-icons
    ];
  };
}
