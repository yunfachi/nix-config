{
  delib,
  inputs,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.spicetify";

  options = delib.singleEnableOption host.guiFeatured;

  myconfig.always.args.shared.spicetifyPkgs = inputs.spicetify.legacyPackages.${pkgs.system};

  myconfig.ifEnabled.persist.user.directories = [".config/spotify" ".cache/spotify"];

  home.always.imports = [inputs.spicetify.homeManagerModules.default];

  home.ifEnabled.programs.spicetify = {
    enable = true;
    alwaysEnableDevTools = true;
  };
}
