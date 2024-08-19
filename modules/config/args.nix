{
  delib,
  config,
  ...
}:
delib.module {
  name = "args";

  options.args = with delib; {
    shared = attrsOption {};
    nixos = attrsOption {};
    home = attrsOption {};
  };

  # nixos.always = {cfg, ...}: {_module.args = cfg.shared // cfg.nixos;};
  # home.always = {cfg, ...}: {_module.args = cfg.shared // cfg.home;};
  nixos.always._module.args = config.myconfig.args.shared // config.myconfig.args.nixos;
  home.always._module.args = config.myconfig.args.shared // config.myconfig.args.home;
}
