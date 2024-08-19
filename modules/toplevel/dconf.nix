{
  delib,
  host,
  colorscheme,
  ...
}:
delib.module {
  name = "dconf";

  options = delib.singleEnableOption host.isDesktop;

  nixos.ifEnabled.programs.dconf.enable = true;

  home.ifEnabled.dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-${colorscheme.polarity}";
    };
  };
}
