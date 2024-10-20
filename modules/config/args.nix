{delib, ...}:
delib.module {
  name = "args";

  options.args = with delib; {
    shared = attrsOption {};
    nixos = attrsOption {};
    home = attrsOption {};
  };

  nixos.always = {cfg, ...}: {_module.args = cfg.shared // cfg.nixos;};
  home.always = {cfg, ...}: {_module.args = cfg.shared // cfg.home;};
}
