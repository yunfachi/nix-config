{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.eza";

  options = {myconfig, ...}: {
    programs.eza = with delib; {
      enable = boolOption host.cliFeatured;
      icons = boolOption myconfig.fonts.enable;
    };
  };

  home.ifEnabled = {cfg, ...}: {
    programs.eza = {
      enable = true;

      git = true;
      icons = cfg.icons;

      extraOptions = [
        "--hyperlink"
        "--no-time"
        "--group-directories-first"
      ];
    };
  };
}
