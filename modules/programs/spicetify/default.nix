{
  delib,
  inputs,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.spicetify";

  options = delib.singleEnableOption host.isDesktop;

  myconfig.always.args.shared.spicetifyPkgs = inputs.spicetify.legacyPackages.${pkgs.system};

  home.always.imports = [inputs.spicetify.homeManagerModules.default];

  home.ifEnabled = {
    programs.spicetify = {
      enable = true;
      alwaysEnableDevTools = true;
    };
  };
}