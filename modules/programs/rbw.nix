{
  delib,
  host,
  decryptSecret,
  pkgs,
  ...
}:
delib.module {
  name = "programs.rbw";

  options.programs.rbw = with delib; {
    enable = boolOption host.guiFeatured;
    baseUrl = strOption null;
  };

  home.ifEnabled =
    { cfg, ... }:
    {
      programs.rbw = {
        enable = true;
        settings = {
          base_url = cfg.baseUrl;
          email = decryptSecret "programs/rbw/email";
          pinentry = pkgs.pinentry-gnome3;
        };
      };
    };
}
