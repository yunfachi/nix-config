{
  delib,
  host,
  colorscheme,
  ...
}:
delib.module {
  name = "dconf";

  options.dconf = with delib; {
    enable = boolOption host.guiFeatured;
    settings = attrsOption {};
  };

  myconfig.always.dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-${colorscheme.polarity}";
  };

  nixos.ifEnabled.programs.dconf.enable = true;

  home.ifEnabled = {cfg, ...}: {
    dconf.settings = cfg.settings;
  };
}
