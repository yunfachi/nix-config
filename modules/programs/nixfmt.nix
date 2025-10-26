{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.nixfmt";

  options.programs.nixfmt = with delib; {
    enable = boolOption host.cliFeatured;
    package = packageOption pkgs.nixfmt;
  };

  home.ifEnabled =
    { cfg, ... }:
    {
      home.packages = [ cfg.package ];
    };
}
